# SQL Practice for Data Analysis

데이터 분석에 필요한 SQL 활용 능력을 기르기 위한 개인 학습 저장소입니다.

단순히 문법을 외우는 것보다, 분석 질문을 읽고 필요한 데이터를 정확히 조회, 필터링, 정렬, 집계하는 연습에 초점을 둡니다. 현재는 PostgreSQL을 기준으로 기본 쿼리, 집계 쿼리, 그룹 필터링을 정리하고 있습니다.

## Goals

- 데이터 분석에서 자주 필요한 조회, 필터링, 정렬, 집계 작업을 SQL로 수행합니다.
- 분석 요구사항을 SQL 쿼리로 변환하는 연습을 반복합니다.
- 학습 내용을 주제별 `.sql` 파일로 정리해 복습하기 쉬운 구조를 만듭니다.
- DB 엔진별 문법 차이를 폴더 단위로 분리해 관리합니다.

## Repository Structure

```text
sql-practice/
  postgreSQL/
    README.md
    00_points_select_all.sql
    01_points_select_xy.sql
    ...
    practice_log.md
```

현재 학습 폴더:

- [postgreSQL](./postgreSQL/README.md): PostgreSQL 기준 SQL 연습과 학습 노트

## Current Topics

| Topic | Status |
|---|---|
| Basic `SELECT` | In progress |
| Filtering with `WHERE` | In progress |
| Sorting with `ORDER BY` | In progress |
| Multiple conditions with `AND` / `OR` | In progress |
| Aggregate functions: `COUNT`, `SUM`, `AVG` | In progress |
| `GROUP BY` | In progress |
| `HAVING` | In progress |

## File Convention

각 학습 항목은 하나의 `.sql` 파일로 저장합니다.

```text
번호_도메인_핵심내용.sql
```

예시:

```text
11_orders_count_by_customer.sql
12_payments_total_by_user.sql
```

파일 내부에는 분석 요구사항을 주석으로 적고, 아래에 SQL을 작성합니다.

```sql
-- PostgreSQL
-- Problem:
-- Write the analysis requirement here.

-- Write the query here.
```
