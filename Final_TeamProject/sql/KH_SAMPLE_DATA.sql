
-- ACCOUNT 테이블 관리자 ID 추가(2022.09.23)
INSERT INTO ACCOUNT(AC_ID, AC_PW, AC_NAME, AC_NICKNAME, AC_PHONE, AC_EMAIL, AC_ROLE, AC_DATE, AC_GROUP, AC_MAIL_AUTH)
VALUES('Admin', 'test1234%', '홍길동', '관리자', '01012345678', 'rulearn@relearn.com', 3, SYSDATE, 1, 1);

INSERT INTO ACCOUNT(AC_ID, AC_PW, AC_NAME, AC_NICKNAME, AC_PHONE, AC_EMAIL, AC_ROLE, AC_DATE, AC_GROUP, AC_MAIL_AUTH)
VALUES('Teacher', 'test1234%', '선생님', '강사', '01012345678', 'teacher@relearn.com', 2, SYSDATE, 1, 1);
     

-- ACCOUNT_GROUP
INSERT INTO ACCOUNT_GROUP
VALUES(ACCOUNT_GROUP_SEQ.NEXTVAL, '일반로그인');
    
INSERT INTO ACCOUNT_GROUP
VALUES(ACCOUNT_GROUP_SEQ.NEXTVAL, '카카오로그인');

-- ROLES
INSERT INTO ROLES
VALUES(ROLES_SEQ.NEXTVAL, '일반회원');

INSERT INTO ROLES
     VALUES(ROLES_SEQ.NEXTVAL, '강사');
    
INSERT INTO ROLES
     VALUES(ROLES_SEQ.NEXTVAL, '관리자');
     
 -- TERM
 INSERT INTO TERM
		VALUES(TERM_SEQ.NEXTVAL, '홈페이지이용약관', 'Y')
     
INSERT INTO TERM
		VALUES(TERM_SEQ.NEXTVAL, '개인정보처리방침', 'Y')
		
-- CATEGORY
INSERT INTO CATEGORY(CAT_ID, CAT_NAME)
VALUES(CATEGORY_SEQ.NEXTVAL
, 'Q&A');

INSERT INTO CATEGORY(CAT_ID, CAT_NAME)
VALUES(CATEGORY_SEQ.NEXTVAL
, '고민자유');

INSERT INTO CATEGORY(CAT_ID, CAT_NAME)
VALUES(CATEGORY_SEQ.NEXTVAL
, '노하우팁');

INSERT INTO CATEGORY(CAT_ID, CAT_NAME)
VALUES(CATEGORY_SEQ.NEXTVAL
, '스터디');

INSERT INTO CATEGORY(CAT_ID, CAT_NAME)
VALUES(CATEGORY_SEQ.NEXTVAL
, '프로젝트');

INSERT INTO CATEGORY(CAT_ID, CAT_NAME)
VALUES(CATEGORY_SEQ.NEXTVAL
, '강의');


INSERT INTO LESSON(L_ID, L_CATID, L_WID, L_TITLE, L_CONTENT, L_PRICE, L_THUMBNAIL, L_LESSON_CATEGORY)
VALUES(LESSON_SEQ.NEXTVAL
		, 6
		, 'Teacher'
		, '애니메이션과 이모티콘 만드는 진짜 애니메이트 클래스'
		, '입문자를 위해 준비한 [그래픽 디자인, 디자인 툴] 강의입니다.
		   나만의 애니메이션과 움직이는 이모티콘을 만들고 싶어하는 초보분들을 위한 어도비 애니메이트 수업입니다.😃
		   나만의 애니메이션을 만들고 싶다면 어도비 애니메이트를 꼭 배워보세요! 👨‍🎓
		   게임 홍보 애니메이션, 캐릭터 라이선싱 회사 홍보 애니메이션 아이돌 그룹 공식 웹툰, 출판 만화, 카카오톡 이모티콘 등 애니메이트로 오랫동안 다양한 콘텐츠를 만든 경험을 바탕으로 애니메이트 입문자분들을 위한 수업을 준비하였습니다!
		   애니메이트로 캐릭터를 드로잉 해봐요.
		   카카오톡에서 판매 중인 움직이는 이모티콘을 그대로 만들어봅니다.
		   2D를 3D처럼 보이게 하는 얼굴 애니메이션 만들기
		   애니메이트만의 손쉬운 방법으로 3D 얼굴 표정을 만들어봅시다.
		   부모 자식 기능으로 점프, 회전하는 캐릭터 만들기
		   하트나 꽃가루 같은 루프 애니메이션 제작 방법
		   한정된 시간에 무한 반복하는 루프 애니메이션 제작 팁을 알려드립니다.'
		, 49500
		,'https://cdn.inflearn.com/public/course-325346-cover/b433bf9a-bffa-41cb-b325-e38aaffd228d'
		, '기타');
		
INSERT INTO LESSON(L_ID, L_CATID, L_WID, L_TITLE, L_CONTENT, L_PRICE, L_THUMBNAIL, L_LESSON_CATEGORY)
VALUES(LESSON_SEQ.NEXTVAL
		, 6
		, 'Teacher'
		, '카프카 완벽 가이드- 코어편'
		, '중급자를 위해 준비한 [데이터 수집 · 처리, 데브옵스 · 인프라] 강의입니다.
		   카프카(Kafka)의 핵심부터 내부 메커니즘에 대한 심화 수준의 내용까지, 상세한 이론 설명과 핸즈온 실습 & 실전 카프카 애플리케이션 개발 실습을 통해 카프카를 시작하는 사람도 단숨에 전문가 레벨로 도달할 수 있도록 강의를 구성했습니다.
		   메시징 시스템 카프카(Kafka)는 대용량 스트리밍 데이터 수집은 물론 대규모 데이터 파이프라인 구축, 이벤트 기반의 마이크로서비스 아키텍처(MSA) 구축 등에서 이제 빼놓을 수 없는 선택지가 되었습니다. 때문에 최근 몇 년간 많은 기업들은 카프카를 앞다투어 도입하고 있으며, 전문 인력에 대한 수요도 지속적으로 증가하고 있습니다.
		   본 강의는 카프카에 대한 이론적 설명에만 그치지 않고 핵심 메커니즘의 내부 동작원리에 대한 상세한 설명과 실습, 실전 카프카 애플리케이션 개발 구현을 통해 여러분을 카프카 운영 및 개발 전문가로 만들어드릴 것입니다.'
		, 99000
		,'https://cdn.inflearn.com/public/courses/329398/cover/5e613ac4-cfe3-4a97-ac6d-929d9cd49647/329398-eng.jpg'
		, '데이터 사이언스');
INSERT INTO LESSON(L_ID, L_CATID, L_WID, L_TITLE, L_CONTENT, L_PRICE, L_THUMBNAIL, L_LESSON_CATEGORY)
VALUES(LESSON_SEQ.NEXTVAL
		, 6
		, 'Teacher'
		, '[실전 게임 코드 리뷰] 유니티 클리커 게임'
		, '중급자를 위해 준비한 [게임 개발, 게임 프로그래밍] 강의입니다.
		   실제로 출시된 2D 클리커 샘플 게임 "개미 주식회사"를 분석하면서 유니티 엔진 응용 방법에 익숙해지는 강의입니다.
		   많은 분들이 실제로 게임을 만드는 경험을 쌓고 싶어하지만, 현실적인 이유로 어려움을 겪기 마련입니다. 
		   [실전 게임 코드 리뷰] 시리즈는 바로 그런 분들을 위해 제작된 강의입니다.
		   실전 감각을 키우고픈 당신을 위해!
		   유니티 엔진 입문 서적은 많지만, 막상 책을 덮고 나면 무엇을 할지가 막막해집니다. 이것저것 만들어 보면서 실습을 해야 실력이 좋아진다는데... 정작 만들어보고 싶은 게임은 딱히 생각나지 않거나, 설령 있더라도 아트 리소스가 없어 고민이 됩니다. 에셋 스토어에서 마음에 드는 리소스를 하나둘 추가하다 보면, 물과 기름처럼 스타일이 상반되고 미관을 해쳐서 의욕이 꺾입니다. 우여곡절 끝에 게임을 만들기 시작했더니, 어디서부터 어떻게 코드를 작성할지 막막하고... 책에서는 아주 간단해 보였던 것들이 하나도 생각나지 않습니다.
		   대부분의 학습자들은 위와 같은 수순을 걷게 됩니다. 저 또한 예외가 아니었습니다. 입문 서적은 많지만 정작 실전 게임을 만들기 위해서는 "그 이상"이 필요한데, 징검다리 역할을 하는 학습 교재들이 너무나 부족한 것이 현실입니다. 실제 게임에 쓰인 샘플 코드를 분석하고 아트팀에서 만들어준 멋진 리소스를 넘겨받아 작업하면 좋은 공부가 되지만, 이런 환경은 취직에 성공하지 않으면 쉽사리 주어지지 않습니다. 이런 분들을 위해 [실전 게임 코드 리뷰] 시리즈 연재를 시작합니다.
		   이 강의만의 특징을 확인해보세요.
		   💡 기존 강의와 다르게 이번 강의는 하나하나 따라 만드는 형태가 아니라, 전체 프로젝트를 제공하고 핵심 기술에 대한 간단한 코드 리뷰만을 진행합니다. 학습자 스스로 소스 코드를 분석하거나, 아트 리소스를 처음부터 재조립하며 한 단계씩 실전 감각을 키우는 것을 유도합니다.'
		, 99000
		,'https://cdn.inflearn.com/public/courses/328083/cover/18fea568-f767-4f8d-99ef-c2fa9e45a6c8/328083-eng.png'
		, '게임개발');
INSERT INTO LESSON(L_ID, L_CATID, L_WID, L_TITLE, L_CONTENT, L_PRICE, L_THUMBNAIL, L_LESSON_CATEGORY)
VALUES(LESSON_SEQ.NEXTVAL
		, 6
		, 'Teacher'
		, '비전공자를 위한 진짜 입문 올인원 개발 클래스'
		, '입문자를 위해 준비한 [웹 개발, 취업 · 이직] 강의입니다.
		   왕초보도 할 수 있는 웹, 서버, 모바일 앱, 머신러닝까지 익히는 끝판왕 풀스택 강의!! 개발을 어디서부터 시작할지 막막했다면 이 강의를 강력 추천할게요. Javascript 하나로 진행합니다!
		   쉽고 다양하게 활용되는 Javascript 로 공부해요!
		   Javascript(자바스크립트)는 웹을 시작으로 서버, 모바일, 머신러닝, 블록체인 등 다양한 분야에서 사용되는 프로그래밍 언어예요.
		   상대적으로 쉬운 난이도로 입문자가 배우기에 적합하고 모든 분야에서 활용될 수 있어요!!
		   이런 걸 만들 거예요👀 - 상품을 사고 팔 수 있는 그랩마켓 서비스를 단계별로 구축합니다.'
		, 99000
		,'https://cdn.inflearn.com/public/courses/326174/cover/b0536120-7de3-4aa8-8266-97cf3881e87d'
		, '개발/프로그래밍');
INSERT INTO LESSON(L_ID, L_CATID, L_WID, L_TITLE, L_CONTENT, L_PRICE, L_THUMBNAIL, L_LESSON_CATEGORY)
VALUES(LESSON_SEQ.NEXTVAL
		, 6
		, 'Teacher'
		, '모든 개발자를 위한 HTTP 웹 기본 지식'
		, '초급자를 위해 준비한 [웹 개발, 개발 · 프로그래밍] 강의입니다.
		   실무에 꼭 필요한 HTTP 핵심 기능과 올바른 HTTP API 설계 방법을 학습합니다.
		   지금 시대는 모든 것을 HTTP로 전송합니다. 우리가 잘 아는 HTML, 이미지, 영상, 파일뿐만 아니라 API로 앱과 서버가 통신할 때, 또 서버와 서버가 통신할 때도 대부분 HTTP를 사용합니다.
		   그래서 모바일 앱 개발자, 웹 프론트엔드 개발자, 백엔드 개발자는 모두 HTTP를 필수로 잘 알고 사용해야 합니다. 특히 백엔드 개발자는 스프링(Spring) 웹 MVC, JSP, PHP, ASP.NET, Node.js, 파이썬 장고, 루비 온 레일즈와 같은 웹 프레임워크나 기술들을 사용하는데, 이러한 웹 기술들은 모두 HTTP를 기반으로 구현되어 있습니다.
		   처음 웹 기술을 공부하는 개발자
		   HTTP를 제대로 이해하지 못한 상태에서 처음 웹 기술들을 공부하면, 깊이있게 원리를 이해하기 쉽지 않습니다. 왜냐하면 해당 기술들은 여러분이 이미 HTTP를 잘 알고 있다고 가정하고, 기능 사용법 위주로 설명하기 때문입니다. 예를 들어 스프링 웹 MVC를 처음 학습하면 HTTP와 관련된 수많은 기능과 용어가 등장하는데, 이런 기능이 왜 필요한지, 이런 용어들이 어디에서 어떤 이유로 나왔는지 명확하게 이해하기 어렵습니다. 그래서 깊이있는 이해보다는 단순히 기능 사용법 위주로 학습하게 됩니다.
		   실무에서 웹 기술을 사용하는 개발자
		   실무에서 웹 기술을 사용하며 오랜 기간 개발을 해도, 고민의 연속입니다. API URL을 이렇게 설계하는 게 맞을까? 언제 POST를 사용하고 PUT를 사용해야 할까? HTTP 상태코드는 어떤 것을 선택하는 게 좋을까? 이런 고민을 계속 하게 됩니다.
		   실무 개발에 꼭 필요한 HTTP 핵심 내용을 학습하고 기준을 세우고 싶은데, 인터넷 자료들은 조각조각 흩어져 있거나 잘못된 내용들이 많습니다. 그렇다고 HTTP 스펙이나 시중의 책들로 학습하기에는 실무에 꼭 필요하지 않은 내용도 많고, 학습량도 부담됩니다. '
		, 44000
		,'https://cdn.inflearn.com/public/courses/326277/cover/52d4f143-b470-4109-96cb-a0b146fb42ed/http.png'
		, '개발/프로그래밍');
INSERT INTO LESSON(L_ID, L_CATID, L_WID, L_TITLE, L_CONTENT, L_PRICE, L_THUMBNAIL, L_LESSON_CATEGORY)
VALUES(LESSON_SEQ.NEXTVAL
		, 6
		, 'Teacher'
		, 'UX/UI 시작하기 : UX 개념 (Inflearn Original)'
		, '입문자를 위해 준비한 [UX/UI] 강의입니다.
		   UX(User Experience, 사용자 경험)의 개념에 대해 익히고, 오늘날 UX 디자인 프로세스 및 디자인 트렌드를 살펴보며 UX/UI에 대한 개념을 전반적으로 학습해 봅니다.
		   오늘날 UX/UI는 서비스를 이끄는 데 있어 중요한 핵심 키워드로 자리를 잡았습니다. 단순히 시각적, 심미적으로만 예쁘고 눈에 띄는 디자인이 아니라 UX를 고려해야 한다는 말이 심심찮게 들려오곤 하죠. UX/UI 디자이너나 기획자를 구한다는 채용 공고도 부쩍 늘었고요. 도대체 UX가 뭐길래 이렇게 주목을 받고 있는 걸까요?
		   이 강의는 UX 입문자를 위해 준비한 UX/UI 기본 개념 강의입니다. 먼저, UX/UI 디자인의 기본 개념을 학습하며 UX 프로젝트를 시작하는 방법을 이해해 볼 거예요. 여기에 실제 프로덕트 디자인 프로세스에서 UX 디자인 방법론을 활용하는 방법을 알려드립니다. 우리 삶에서 UX가 하는 역할, 유래와 역사는 물론 다양한 UX 디자인 방법론과 디자인 프로세스 사례 분석을 통해 UX/UI에 대한 개념을 전반적으로 알려드릴 거예요.
		   끝으로 여러분께 요즘 가장 주목받는 디자인 시스템과 UX Writing 등을 소개합니다. 시장이 빠르게 움직이는 만큼 소비자의 요구도 빠르게 변화하고 있죠. 이러한 흐름에 민감하게 대처하려면 누구보다 예민하게 트렌드를 관찰하는 눈이 필요한데요, 수업을 통해 거시적인 관점에서 트렌드를 파악하고 분석할 수 있도록 차근차근 다양한 케이스를 살펴보고 짚어나갈 예정입니다. 그럼, 함께 시작해볼까요?'
		, 55000
		,'https://cdn.inflearn.com/public/courses/326391/cover/750e846b-96d3-4aa5-ab18-a94d099692df'
		, '개발/프로그래밍');
INSERT INTO LESSON(L_ID, L_CATID, L_WID, L_TITLE, L_CONTENT, L_PRICE, L_THUMBNAIL, L_LESSON_CATEGORY)
VALUES(LESSON_SEQ.NEXTVAL
		, 6
		, 'Teacher'
		, 'Autodesk Maya 2020 Effects and Motion의 입문 Part.4'
		, '초급자를 위해 준비한 [CAD · 3D 모델링, 디자인 툴] 강의입니다.
		   Maya 2020 버전이 가진 3D 효과 및 모션그래픽 작업에 필요한 기본 기능을 익힐 수 있습니다. (네 번째 파트)
		   오늘날 UX/UI는 서비스를 이끄는 데 있어 중요한 핵심 키워드로 자리를 잡았습니다. 단순히 시각적, 심미적으로만 예쁘고 눈에 띄는 디자인이 아니라 UX를 고려해야 한다는 말이 심심찮게 들려오곤 하죠. UX/UI 디자이너나 기획자를 구한다는 채용 공고도 부쩍 늘었고요. 도대체 UX가 뭐길래 이렇게 주목을 받고 있는 걸까요?
		   Maya Effects & Motion?
		   "Autodesk Maya 2020 Effects and Motion의 입문" 강의는 Maya 2020 버전이 가진 효과와 모션 작업을 위해 사용할 수 있는 기본 기능에 입문하는 과정입니다. 전체 과정은 총 네 개의 강의로 구성되어 있습니다.
		   네 번째 파트에서는 nCloth와 Fluid Effect Container의 기본적인 역할에 대해 알아봅니다. nCloth의 기본 생성과 함께 오브젝트와 충돌을 일으키고, Constraint 구속 제어 장치를 연결해 nCloth 모션을 만드는 방법과 페인팅 방식으로 nCloth의 속성을 제어하는 기능에 대해서도 함께 배웁니다. 
		   볼륨 기반의 유체 역학 모션을 만들어내는 Fluid Container의 기본적인 생성 및 활용 방법과 함께, 불과 연기를 만들어서 렌더링 결과까지 확인해 봅니다. 뿐만 아니라 Fluid Container의 여러 물리적인 속성을 일으키는 Make motion field, pond 같은 시스템의 역할에 대해서도 알아볼 것입니다. '
		, 35200
		,'https://cdn.inflearn.com/public/courses/326856/cover/6ada7721-1d87-475c-a54e-a496d98f43a0/326856-eng.png'
		, '기타');
INSERT INTO LESSON(L_ID, L_CATID, L_WID, L_TITLE, L_CONTENT, L_PRICE, L_THUMBNAIL, L_LESSON_CATEGORY)
VALUES(LESSON_SEQ.NEXTVAL
		, 6
		, 'Teacher'
		, '코딩으로 학습하는 GoF의 디자인 패턴'
		, '초급자를 위해 준비한 [프로그래밍 언어, 개발 도구] 강의입니다.
		   디자인 패턴을 알고 있다면 스프링 뿐 아니라 여러 다양한 기술 및 프로그래밍 언어도 보다 쉽게 학습할 수 있습니다. 또한, 보다 유연하고 재사용성이 뛰어난 객체 지향 소프트웨어를 개발할 수 있습니다.
		   모든 개발자의 필독서 - GoF의 디자인 패턴
		   단순한 구현을 벗어나 더 좋은 코드를 만들고 싶다면 디자인 패턴에 대한 이해가 반드시 필요합니다.
		   모든 개발자에게 필독서로 추천하는 GoF의 저서 《디자인 패턴》과 23가지의 디자인 패턴.
		   현직 마이크로소프트 개발자가 현업에서 사용하는 코드로 모든 디자인 패턴을 알려드립니다.
		   우리가 디자인 패턴을 배워야 하는 이유
		   디자인 패턴은 애플리케이션 개발 시에 마주할 다양한 문제와 패턴을 모아놓은 지식의 산물입니다.
		   실제로 자바 개발자가 많이 사용하는 스프링 프레임워크에도 전략, 프록시, 어댑터 등 여러 다양한 디자인 패턴을 찾아볼 수 있습니다.
		   이 강의는 여러분께 디자인 패턴이 어렵고 추상적인 이론이 아니라 이미 우리 가까이에 있다는 것을 알게 해줄 것입니다. 
		   프레임워크 학습에 어려움을 겪는다면
		   스프링이나 리액트, NestJS와 같은 프레임워크에는 고도의 기술과 디자인 패턴이 집약되어있습니다.
		   프레임워크 학습에 어려움을 느꼈다면 디자인 패턴에 대한 이해가 선행되어야 합니다.
		   디자인 패턴을 알고 있다면 자바나 스프링뿐 아니라 여러 다양한 기술 및 프로그래밍 언어도 더 쉽게 학습할 수 있습니다.'
		, 88000
		,'https://cdn.inflearn.com/public/courses/327819/cover/24e9812b-a7ad-4f36-8065-f3d24aa765b9/327819-eng.png'
		, '개발/프로그래밍');
INSERT INTO LESSON(L_ID, L_CATID, L_WID, L_TITLE, L_CONTENT, L_PRICE, L_THUMBNAIL, L_LESSON_CATEGORY)
VALUES(LESSON_SEQ.NEXTVAL
		, 6
		, 'Teacher'
		, '모의해킹 실무자가 알려주는, SQL Injection 공격 기법과 시큐어 코딩 : PART 1'
		, '초급자를 위해 준비한 [보안] 강의입니다.
		   모의해킹 실무자가 알려주는, 웹 해킹의 꽃 SQL Injection! 공격과 방어를 동시에 배워보세요.
		   왜 SQL Injection을 배워야 할까?
		   웹 해킹계의 인싸! 많은 사람들이 알고 있다는 것은 그만큼 해당 공격이 가지고 있는 영향력이 크다는 것이겠죠?
		   오늘날의 웹 어플리케이션들은 대부분 사용자 입력 값을 통해 동적으로 페이지를 구성하는 기능들이 많이 있습니다. 이런 환경 속에서, 공격자 관점에서는 공격 대상이 많아짐에 따라 효과적인 분석 방법 그리고 각 상황에 따른 공격 기법 등의 공격 기술을 필요로 합니다. 반대로, 방어자 관점에서는 효과적인 방어를 위해 인라인 구간에 보안 솔루션을 설치하거나, 시큐어 코딩을 하게 됩니다. 공격을 알아야 방어를 할 줄 알겠죠?
		   실무에서 바로 적용 가능한 공격 기술!
		   효과적인 취약점 분석을 위해 다양한 공격 포인트에 대해 어떤 방법론으로 분석을 해야 되며, 어떤 환경에서 어떤 공격을 해야 될지 기준이 명확해지고 이에 따른 공격 기법들을 배우게 됩니다. 이러한 실무에서 사용하고 있는 각 공격 기법에 대해 자세히 다룹니다.
		   각 DBMS에 대한 PHP 기반의 실습 게시판 제공!
		   PHP-MYSQL, PHP-MSSQL, PHP-ORACLE 기반의 실습 게시판을 제공해드리며, 이를 통해 다양한 DBMS별 SQL Injection 실습이 가능합니다. 
		   따라하면서 배우는 SQL Injection 공격 기법과 시큐어 코딩!
		   SQL Injection 공격 기법을 완성하기 위한 각 기술 요소들을 이론에서 끝나는 것이 아니라 DBMS별로 직접 실습을 진행합니다.'
		, 123750
		,'https://cdn.inflearn.com/public/courses/324949/course_cover/dc53436d-1025-46e0-bd9d-ffbcc9221ff7/sql-injection-secure-coding-pt1-eng.png'
		, '보안/네트워크');
INSERT INTO LESSON(L_ID, L_CATID, L_WID, L_TITLE, L_CONTENT, L_PRICE, L_THUMBNAIL, L_LESSON_CATEGORY)
VALUES(LESSON_SEQ.NEXTVAL
		, 6
		, 'Teacher'
		, '[입문자를 위한 UE5] Part1. 언리얼 엔진 블루프린트'
		, '입문자를 위해 준비한 [게임 프로그래밍, 게임 개발] 강의입니다.
		   아무것도 모르는 입문자를 위한 강의 입니다. 언리얼 엔진의 비주얼 스크립팅 시스템인 블루프린트를 프로그래머 관점에서 공부하며 익숙해지는 강의입니다.
		   기존에 연재된 강의들은 신입 프로그래머 교육 용도로 제작되어 프로그래밍을 처음 접하시는 분들한테는 난이도가 높은 편이었습니다. 또한 MMORPG 특성상 내용이 서버 쪽에 치중되어 클라이언트 개발을 지망하는 분들에게는 아쉬움이 남는 커리큘럼이었습니다.
		   이런 문제들을 해소하기 위해, 입문자들을 타겟으로 하는 새로운 학습 시리즈들을 본격적으로 연재하고자 합니다.
		   블루프린트(Blueprint)는 언리얼 엔진에서 제공하는 비주얼 코딩 시스템입니다. 복잡한 C++ 언어를 배우지 않아도, 이리 저리 노드들을 연결하다 보면 신기하게도 게임이 완성되기 때문에 입문자들에게 특히 인기가 많습니다. 스팀에 출시된 일부 게임들은, 한 줄의 코딩도 없이 블루프린트를 기반으로 만들어진 게임들입니다.
		   C++에 비해 실행 속도가 느리다는 단점은 있지만, 간단한 프로토타이핑을 하거나 (UI나 애니메이션 등) 일부 기능을 사용할 때 강점이 있기 때문에 대부분의 프로젝트에서는 C++과 블루프린트를 혼용해서 사용합니다.
		   블루프린트는 단순해 보여도 다른 프로그래밍 언어에서 제공하는 고급 기능들을 대부분 포함하고 있습니다. 그러나 실존하는 대부분의 블루프린트 서적과 강의에서는 블루프린트의 단순함을 강조하기 위해 몇 가지 기초적인 부분에 대해서만 실습을 하고 넘어갑니다. 이렇게 학습할 경우, 훗날 진지하게 게임을 만드려 할 때 기본기가 부족해 큰 벽에 부딪히게 됩니다.
		   본 강의에서는 블루프린트를 C++, C#과 동일 선상에 있는 하나의 프로그래밍 언어로 간주하고, 게임을 만들기 위해 필요한 다양한 문법에 대해서 순차적으로 공부하게 됩니다.
		   이 강의만의 특징을 확인해보세요. 
		   💡 블루프린트를 블루프린트답게! 코드를 직접 콘솔에 입력하지 않더라도, 블루프린트에서 제공하는 인터페이스 기반의 기능들로 게임을 구현하는 과정을 ‘프로그래밍 관점’에서 쉽고 재미있게 배울 수 있도록 도와드립니다. 코딩을 처음 접하는 입문자는 물론, 실제 게임 개발에 블루프린트를 적용하고자 하는 아마추어 게임 개발자나 게임 회사 취업 준비생에게도 유익한 내용으로 구성했습니다.'
		, 123750
		,'https://cdn.inflearn.com/public/courses/329214/cover/0d3f339b-06de-40c3-a41a-8633df325ade/329214-eng.jpg'
		, '게임개발');
		

--table CURRICULUM_BIG에 data 추가
INSERT INTO CURRICULUM_BIG VALUES(1, 1, '애니메이트 소개');
INSERT INTO CURRICULUM_BIG VALUES(1, 2, '처음 사용자를 위한 애니메이트 살펴보기');
INSERT INTO CURRICULUM_BIG VALUES(1, 3, '나만의 캐릭터를 만들자');
INSERT INTO CURRICULUM_BIG VALUES(1, 4, '애니메이트의 필수 기능 심화 학습');

INSERT INTO CURRICULUM_BIG VALUES(2, 1, '강의 소개 및 실습 환경 구성');
INSERT INTO CURRICULUM_BIG VALUES(2, 2, 'Kakfa Topic, Producer, Consumer 이해 및 CLI로 실습 해보기');
INSERT INTO CURRICULUM_BIG VALUES(2, 3, 'Java 기반 Producer 구현 실습 및 Producer 내부 메커니즘 이해 - 01');

INSERT INTO CURRICULUM_BIG VALUES(3, 1, 'OT');
INSERT INTO CURRICULUM_BIG VALUES(3, 2, 'UI 기반 게임 제작');
INSERT INTO CURRICULUM_BIG VALUES(3, 3, '컨텐츠 제작');
INSERT INTO CURRICULUM_BIG VALUES(3, 4, '마무리');



--table CURRICULUM_SMALL에 data 추가
INSERT INTO CURRICULUM_SMALL VALUES(1, 1, 1, '애니메이트는 어떤 프로그램인가?', 'VIDEO', '04:55');
INSERT INTO CURRICULUM_SMALL VALUES(1, 2, 1, '애니메이트 기본 화면 및 기본 도구 살펴보기', 'VIDEO', '10:45');
INSERT INTO CURRICULUM_SMALL VALUES(1, 2, 2, '환경 설정과 단축키 세팅하기', 'VIDEO', '04:47');
INSERT INTO CURRICULUM_SMALL VALUES(1, 3, 1, '이모티콘을 위한 캐릭터를 구상하는 법', 'VIDEO', '05:32');
INSERT INTO CURRICULUM_SMALL VALUES(1, 3, 2, '애니메이트의 기본 드로잉 방법', 'VIDEO', '07:09');
INSERT INTO CURRICULUM_SMALL VALUES(1, 3, 3, '애니메이트의 캐릭터 드로잉 방법', 'VIDEO', '15:01');
INSERT INTO CURRICULUM_SMALL VALUES(1, 3, 4, '애니메이션 작업 전 캐릭터 세팅하는 법', 'VIDEO', '05:38');
INSERT INTO CURRICULUM_SMALL VALUES(1, 4, 1, '타임 라인', 'VIDEO', '05:54');
INSERT INTO CURRICULUM_SMALL VALUES(1, 4, 2, '심볼', 'VIDEO', '10:24');
INSERT INTO CURRICULUM_SMALL VALUES(1, 4, 3, '트위닝', 'VIDEO', '19:55');

INSERT INTO CURRICULUM_SMALL VALUES(2, 1, 1, '강의 소개', 'VIDEO', '07:17');
INSERT INTO CURRICULUM_SMALL VALUES(2, 1, 2, '강의 커리큘럼 및 실습 코드 소개', 'VIDEO', '06:06');
INSERT INTO CURRICULUM_SMALL VALUES(2, 1, 3, '강의 교재 및 실스 코드 다운로드', 'DOCUMENT', NULL);
INSERT INTO CURRICULUM_SMALL VALUES(2, 2, 1, '카프카, 시작하며', 'VIDEO', '02:58');
INSERT INTO CURRICULUM_SMALL VALUES(2, 2, 2, 'Topic과 Partition 그리고 카프카 병렬 분산 처리 개요', 'VIDEO', '15:51');
INSERT INTO CURRICULUM_SMALL VALUES(2, 2, 3, 'kafka-topics 명령어를 이용하여 Topic 생성 및 정보 확인하기', 'VIDEO', '12:10');
INSERT INTO CURRICULUM_SMALL VALUES(2, 3, 1, 'Java기반의 카프카 클라이언트 구현 실습을 시작하며', 'VIDEO', '02:38');
INSERT INTO CURRICULUM_SMALL VALUES(2, 3, 2, 'Java 기반 카프카 클라이언트(Client) 구현 실습을 위한 JDK및 Intellij 설치', 'VIDEO', '09:06');
INSERT INTO CURRICULUM_SMALL VALUES(2, 3, 3, 'Java 기반 카프카 클라이언트 구현을 위한 Intellij 프로젝트 설정 및 멀티 Module 설정하기', 'VIDEO', '06:15');

INSERT INTO CURRICULUM_SMALL VALUES(3, 1, 1, 'OT', 'VIDEO', '06:04');
INSERT INTO CURRICULUM_SMALL VALUES(3, 1, 2, '프로젝트 다운로드', 'VIDEO', '03:17');
INSERT INTO CURRICULUM_SMALL VALUES(3, 1, 3, '환경 설정', 'DOCUMENT', '22:20');
INSERT INTO CURRICULUM_SMALL VALUES(3, 2, 1, 'Sprite vs UI', 'VIDEO', '20:58');
INSERT INTO CURRICULUM_SMALL VALUES(3, 2, 2, '프리팹 제작 및 실전 팁', 'VIDEO', '31:46');
INSERT INTO CURRICULUM_SMALL VALUES(3, 3, 1, '게임 컨텐츠 제작 및 설계', 'VIDEO', '25:10');
INSERT INTO CURRICULUM_SMALL VALUES(3, 4, 1, '광고와 인앱 결제', 'VIDEO', '16:19');












