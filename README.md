# 인천대학교 스마트캠퍼스 for iOS (구버전)

iOS 개발 : 조준영(인천대학교 컴퓨터공학과), 김민수(인천대학교 수학과), 김선일(인천대학교 정보통신공학과)
https://itunes.apple.com/kr/app/smartcampusinu/id1123199010?mt=8

## 주요 기능(괄호 안의 내용은 각 기능 개발자)

1. 학교 공지사항()

학교 공지사항을 모아서 보여줌.

2. 학사 일정(김민수)

캘린더뷰에 학사 일정을 보여줌.

3. 시간표(조준영)

학생 별 시간표, 수강하는 과목의 목록과 상세 정보, 수강인을 확인할 수 있음.

4. 도서관(조준영)

도서관의 현재 좌석 현황을 확인할 수 있음.

5. 식당(김선일)

교내 식당의 일간 식단 정보와 영업 시간 제공.

6. 학점(김선일)

학생의 총 취득학점/평점 확인, 학기별 성적 확인.

7. 캠퍼스맵(김선일)

교내 건물들의 위치 안내.

8. 게시판(조준영)

학생 커뮤니티 제공.

## 사용한 라이브러리

1. Alamofire

서버와 http 통신을 하기 위해 사용.

2. ObjectMapper / AlamofireObjectMapper

서버로부터 json을 받을 때 쉽게 자료를 맵핑하기 위해 사용.

3. RIGImageGallery

메인 화면 광고 출력을 위해 사용.

4. XLPagerStrip

안드로이드의 탭 페이저 구현하기 위해서 사용.

5. Kingfisher

ImageView에 웹에서 이미지를 받아 출력하기 위해 사용.

6. RxSwift, RxCocoa, RxDataSources

Rx 개발을 위해 사용.(부분 적용)

7. GoogleMaps

캠퍼스맵에서 지도를 출력하기 위해 사용.

8. RealmSwift

데이터베이스.

9. JTAppleCalendar

캘린더뷰 사용.

10. NVActivityIndicatorView

로딩 중 화면을 보여주기 위해 사용.

11. Toaster

안내 메시지를 띄우기 위해 사용.
