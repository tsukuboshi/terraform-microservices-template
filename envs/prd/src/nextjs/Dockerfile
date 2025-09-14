FROM public.ecr.aws/docker/library/node:20-slim AS base

ARG NEXTJS_SRC_PATH=src/nextjs

FROM base AS deps
WORKDIR /app
COPY ${NEXTJS_SRC_PATH}/package*.json ./
RUN npm ci

FROM base AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY ${NEXTJS_SRC_PATH}/. .
ENV NEXT_TELEMETRY_DISABLED=1
RUN npm run build

FROM base AS runner
WORKDIR /app
ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1

COPY --from=builder /app/public ./public
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static

EXPOSE 3000

CMD ["node", "server.js"]
