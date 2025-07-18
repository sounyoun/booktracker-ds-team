## 2025-1 자료구조 D반 5조 - 나만의 책탑


### 주제: 자료구조 기반 독서 기록 시각화 앱
*(Data Structure-based Reading Tracker Visualization App)*

> 이 앱은 기존 독서 기록 앱을 기반으로,
> 필요하지 않은 기능을 제외하고 자료구조 수업의 학습 목적에 맞게 재구성하였으며,
> 학습 범위 확장을 위해 명언 출력 기능을 새롭게 개발하여 추가했습니다.

---
### 주요 기능
- 책 시각화(List): 입력한 책 정보의 페이지 수를 기반으로 블록 쌓기

  <img src="images/book_input.png" alt="설명" width="300"/> <img src="images/book_block.png" alt="설명" width="300"/>

- 팝업 정보: 책 블록 클릭 시 상세 정보 확인 기능

  <img src="images/block_function.png" alt="설명" width="300"/> <img src="images/book_info.png" alt="설명" width="300"/>
  
- 명언(List): 메인 상단에 명언이 20초마다 전환되며 출력

  <img src="images/quote1.png" alt="설명" width="300"/> <img src="images/quote2.png" alt="설명" width="300"/>

- 목표: 목표에 따른 진행 막대와 달성 여부 알림

  <img src="images/goal_alarm2.png" alt="설명" width="300"/> <img src="images/goal_note.png" alt="설명" width="300"/>

---
### 개발 환경
- Flutter: 앱 개발 프레임워크
- VSCode: 코드 작성
- Android Studio: 에뮬레이터

---
### 조원별 역할 분담
- **신정환**: 책 등록 및 입력 처리 기능 구현
- **윤소운**: 데이터 처리 및 삭제 로직
- **임석민**: 목표 및 진행률 표시 로직
- **서현아**: 명언 출력 및 디자인

---
### 시연 영상: [youtube 링크](https://youtube.com/shorts/WDhXVpSydcY?feature=share)

<p>
  <a href="https://www.youtube.com/watch?v=WDhXVpSydcY">
    <img src="https://img.youtube.com/vi/WDhXVpSydcY/0.jpg" alt="시연 영상 썸네일" width="400">
  </a>
</p>

---
### 문제점 및 해결 방안
1. **개발 환경 세팅**
   - 문제점: 팀원 모두 처음 사용하는 개발 툴로, 특히 SDK 관련 오류 발생
   - 해결 방안: 다양한 개발 환경 세팅 방법을 참고해 SDK의 올바른 경로 설정

2. **디자인 작업 시 기능 오류**
   - 문제점: 기능 개발 후 디자인 요소 추가 시 기존 기능이 정상 작동하지 않음
   - 해결 방안: 오류가 없었던 버전으로 돌아가 디자인 요소를 하나씩 추가
