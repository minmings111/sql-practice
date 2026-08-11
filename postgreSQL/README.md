# PostgreSQL Practice

PostgreSQL 기준 SQL 학습 파일을 모아두는 폴더입니다.

이 README는 폴더의 구조와 사용 방식을 안내합니다. 문법 노트와 자주 헷갈린 포인트는 [practice_log.md](./practice_log.md)에 정리합니다.

## File Roles

| File type | Role |
|---|---|
| `*.sql` | 하나의 분석 요구사항과 실행 가능한 SQL 쿼리를 담는 연습 파일 |
| `*_todo_*.sql` | 아직 풀이하지 않은 연습용 템플릿 |
| `practice_log.md` | PostgreSQL 문법 노트와 헷갈린 포인트 정리 |
| `README.md` | 이 폴더의 목적, 파일 규칙, 사용 방식 안내 |

## File Convention

각 SQL 파일은 아래 형식으로 이름을 붙입니다.

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

## How I Use This Folder

1. 새 분석 요구사항을 하나의 `.sql` 파일로 만든다.
2. 먼저 직접 쿼리를 작성한다.
3. 풀이 쿼리는 해당 `.sql` 파일에서 관리한다.
4. 헷갈린 문법이나 반복되는 실수는 `practice_log.md`에 문법 노트로 정리한다.

## Current Topics

| Topic | Status |
|---|---|
| Basic `SELECT` | In progress |
| Filtering with `WHERE` | In progress |
| Sorting with `ORDER BY` | In progress |
| Multiple conditions with `AND` / `OR` | In progress |
| Boolean filtering | In progress |
| Aggregate functions: `COUNT`, `SUM`, `AVG` | In progress |
| `GROUP BY` | In progress |
| `HAVING` | In progress |
| `JOIN` | In progress |

## Practice Files

| File | Topic |
|---|---|
| [00_points_select_all.sql](./00_points_select_all.sql) | 전체 데이터 조회 |
| [01_points_select_xy.sql](./01_points_select_xy.sql) | 특정 컬럼 조회 |
| [02_points_filter_i_order_y.sql](./02_points_filter_i_order_y.sql) | 조건 필터링과 정렬 |
| [03_points_filter_ii_order_x.sql](./03_points_filter_ii_order_x.sql) | 조건 필터링과 정렬 |
| [04_points_filter_iii_order_y_desc.sql](./04_points_filter_iii_order_y_desc.sql) | 내림차순 정렬 |
| [05_points_filter_iv_order_id_desc.sql](./05_points_filter_iv_order_id_desc.sql) | ID 기준 내림차순 정렬 |
| [06_points_filter_i_y_gte_8.sql](./06_points_filter_i_y_gte_8.sql) | 여러 조건 필터링 |
| [07_points_filter_ii_x_gt_10.sql](./07_points_filter_ii_x_gt_10.sql) | 여러 조건 필터링 |
| [08_points_filter_iii_y_lt_7_select_columns.sql](./08_points_filter_iii_y_lt_7_select_columns.sql) | 조건 필터링과 특정 컬럼 조회 |
| [09_points_filter_i_or_iv_order.sql](./09_points_filter_i_or_iv_order.sql) | 여러 값 조건과 다중 정렬 |
| [10_points_i_or_ii_y_gt_8.sql](./10_points_i_or_ii_y_gt_8.sql) | 여러 값 조건과 숫자 조건 조합 |
| [11_orders_count_by_customer.sql](./11_orders_count_by_customer.sql) | 고객별 주문 개수 |
| [12_payments_total_by_user.sql](./12_payments_total_by_user.sql) | 사용자별 결제 금액 합계 |
| [13_reviews_avg_rating_by_product.sql](./13_reviews_avg_rating_by_product.sql) | 상품별 평균 평점 |
| [14_orders_completed_total_amount_having.sql](./14_orders_completed_total_amount_having.sql) | 그룹별 합계 조건 필터링 |
| [15_payments_count_and_total_by_user.sql](./15_payments_count_and_total_by_user.sql) | 사용자별 결제 횟수와 합계 |
| [16_products_active_avg_price_having.sql](./16_products_active_avg_price_having.sql) | Boolean 조건과 평균값 필터링 |
| [17_orders_completed_with_customer_name.sql](./17_orders_completed_with_customer_name.sql) | 주문과 고객 테이블 연결 |
| [18_customers_completed_order_total_having.sql](./18_customers_completed_order_total_having.sql) | JOIN과 그룹별 합계 필터링 |
