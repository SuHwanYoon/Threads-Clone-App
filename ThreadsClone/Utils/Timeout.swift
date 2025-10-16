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
func withTimeout<T>(seconds: TimeInterval, operation: @escaping () async throws -> T) async throws -> T {
    // Task.init(priority:operation:)는 새로운 비동기 작업을 생성합니다.
    // operation 클로저가 이 작업의 내용이 됩니다.
    return try await withCheckedThrowingContinuation { continuation in
        let timeoutTask = Task {
            do {
                try await Task.sleep(nanoseconds: UInt64(seconds * 1_000_000_000))
                continuation.resume(throwing: TimeoutError.timedOut)
            } catch {
                // 이 catch 블록은 Task.sleep이 취소될 때 실행됩니다.
                // operation이 성공적으로 완료되면 timeoutTask가 취소되므로,
                // 여기서는 아무것도 할 필요가 없습니다.
            }
        }

        _ = Task {
            do {
                let result = try await operation()
                timeoutTask.cancel()
                continuation.resume(returning: result)
            } catch {
                timeoutTask.cancel()
                continuation.resume(throwing: error)
            }
        }
    }
}
