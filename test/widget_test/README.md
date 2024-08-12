짜다보니 위젯테스트랑 통합테스트의 경계가 모호해서 그냥 위젯테스트들을 통합테스트 느낌으로 사용하면서 별도의 통합테스트는 작성하지 않기로 했습니다.
모든 위젯테스트를 수행하면 그것이 곧 end-to-end 통합테스트를 돌린것과 동일한 효과가 나도록 테스트를 설계하였습니다.

As I continued developing, the boundary between widget tests and integration tests became blurred, so I decided to use widget tests in a way that feels like integration tests and not write separate integration tests.
Running all the widget tests will be equivalent to running end-to-end integration tests, as I have designed the tests in that way.