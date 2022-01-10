# Dockerfile

FROM node:12 as build
WORKDIR /build
RUN yarn global add tech-radar-generator@0.4
COPY example-data.json /build/
RUN tech-radar-generator example-data.json /build/dist

FROM nginx:1.17.3
WORKDIR /opt/radar
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /build/dist .
CMD ["nginx", "-g", "daemon off;"]