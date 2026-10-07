# portfolio.html 하나를 nginx로 서비스하는 Render Web Service(Docker)용 설정
# - 저장소 맨 위(루트)에 portfolio.html 과 이 Dockerfile 이 같이 있어야 한다
# - Render는 PORT 환경변수(기본 10000)로 접속하므로 nginx가 그 포트를 듣게 한다
FROM nginx:1.27-alpine
ENV PORT=10000
RUN mkdir -p /etc/nginx/templates && printf '%s\n' \
  'server {' \
  '  listen ${PORT};' \
  '  root /usr/share/nginx/html;' \
  '  index index.html;' \
  '  location / { try_files $uri $uri/ /index.html; }' \
  '}' > /etc/nginx/templates/default.conf.template
# 주소창에 사이트 주소만 쳐도 열리도록 index.html 이름으로 복사
COPY portfolio.html /usr/share/nginx/html/index.html
