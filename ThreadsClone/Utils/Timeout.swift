import Foundation

// 에러 타입을 정의합니다.
enum TimeoutError: Error, LocalizedError {
    case timedOut
    
    var errorDescription: String? {
        switch self {
        case .timedOut:
            return "요청 시간이 초과되었습니다. 다시 시도해주세요."
        }
    }
}

// withTimeout 함수는 비동기 작업에 시간 초과를 설정하는 역할을 합니다.
// seconds: 시간 초과를 설정할 시간(초)입니다.
// operation: 실행할 비동기 작업입니다. 이 작업은 T 타입을 반환하고 에러를 던질 수 있습니다.
// @escaping: operation 클로저가 withTimeout 함수의 스코프를 벗어나서도 존재할 수 있음을 나타냅니다.
// T: 제네릭 타입으로, operation이 반환하는 값의 타입입니다.
func withTimeout<T: Sendable>(seconds: TimeInterval, operation: @escaping @Sendable () async throws -> T) async throws -> T {
    return try await withThrowingTaskGroup(of: T.self) { group in
        // 1. 실제 작업을 그룹에 추가합니다.
        group.addTask(operation: operation)
        
        // 2. 타임아웃 작업을 그룹에 추가합니다.
        group.addTask {
            try await Task.sleep(for: .seconds(seconds))
            throw TimeoutError.timedOut
        }
        
        // 3. 그룹에서 가장 먼저 완료되는 작업의 결과를 기다립니다.
        let result = try await group.next()!
        
        // 4. 한 작업이 완료되면 나머지 작업을 모두 취소합니다.
        group.cancelAll()
        
        return result
    }
}
