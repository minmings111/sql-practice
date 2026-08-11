# PostgreSQL Syntax Notes

PostgreSQL로 데이터 분석 쿼리를 작성할 때 자주 쓰는 문법과 헷갈렸던 포인트를 정리합니다.

이 파일은 풀이 쿼리를 저장하는 곳이 아닙니다. 실제 연습 쿼리는 각 `.sql` 파일에서 관리하고, 이 파일에서는 문법 자체와 작성할 때의 기준만 정리합니다.

## Practice File Links

| Topic | Files |
|---|---|
| 전체 조회와 컬럼 선택 | [00](./00_points_select_all.sql), [01](./01_points_select_xy.sql) |
| 조건 필터링과 정렬 | [02](./02_points_filter_i_order_y.sql), [03](./03_points_filter_ii_order_x.sql), [04](./04_points_filter_iii_order_y_desc.sql), [05](./05_points_filter_iv_order_id_desc.sql) |
| 여러 조건 조합 | [06](./06_points_filter_i_y_gte_8.sql), [07](./07_points_filter_ii_x_gt_10.sql), [08](./08_points_filter_iii_y_lt_7_select_columns.sql) |
| 여러 값 조건 | [09](./09_points_filter_i_or_iv_order.sql), [10](./10_points_i_or_ii_y_gt_8.sql) |
| Boolean 조건 | [16](./16_products_active_avg_price_having.sql) |
| 집계와 그룹화 | [11](./11_orders_count_by_customer.sql), [12](./12_payments_total_by_user.sql), [13](./13_reviews_avg_rating_by_product.sql), [15](./15_payments_count_and_total_by_user.sql), [16](./16_products_active_avg_price_having.sql), [18](./18_customers_completed_order_total_having.sql), [23](./23_orders_status_amount_by_customer.sql) |
| 계산식과 집계 | [20](./20_order_items_active_category_sales.sql), [21](./21_orders_completed_total_paid_discount.sql), [22](./22_orders_completed_total_charged_tax.sql) |
| 그룹 결과 필터링 | [14](./14_orders_completed_total_amount_having.sql), [16](./16_products_active_avg_price_having.sql), [18](./18_customers_completed_order_total_having.sql), [20](./20_order_items_active_category_sales.sql), [21](./21_orders_completed_total_paid_discount.sql), [22](./22_orders_completed_total_charged_tax.sql) |
| 테이블 연결 | [17](./17_orders_completed_with_customer_name.sql), [18](./18_customers_completed_order_total_having.sql), [20](./20_order_items_active_category_sales.sql), [21](./21_orders_completed_total_paid_discount.sql), [22](./22_orders_completed_total_charged_tax.sql) |
| 조건부 집계 | [19](./19_events_latest_value_difference.sql), [23](./23_orders_status_amount_by_customer.sql) |
| 윈도우 함수 | [19](./19_events_latest_value_difference.sql) |

## Query Order

SQL은 보통 아래 순서로 작성합니다.

```sql
SELECT
FROM
WHERE
GROUP BY
HAVING
ORDER BY
```

처음에는 이 순서를 외워두는 것이 중요합니다. 특히 `FROM`이 `WHERE`보다 먼저 옵니다.

## Strings

PostgreSQL에서 문자열은 작은따옴표로 감쌉니다.

```sql
'completed'
'card'
'I'
```

쌍따옴표는 문자열이 아니라 컬럼명이나 테이블명 같은 식별자를 감쌀 때 사용합니다.

## SELECT

모든 컬럼을 조회할 때는 `*`를 사용합니다.

```sql
SELECT *
```

필요한 컬럼만 조회할 때는 컬럼명을 쉼표로 구분합니다.

```sql
SELECT column_a, column_b
```

결과 컬럼명을 바꾸고 싶을 때는 `AS`로 별칭을 붙입니다.

```sql
SELECT expression AS alias_name
```

## WHERE

`WHERE`는 필요한 행만 남기는 조건절입니다.

자주 쓰는 비교 연산자:

| Operator | Meaning |
|---|---|
| `=` | 같다 |
| `<>` | 같지 않다 |
| `>` | 크다 |
| `>=` | 크거나 같다 |
| `<` | 작다 |
| `<=` | 작거나 같다 |

PostgreSQL에서 같은지 비교할 때는 `==`가 아니라 `=`를 사용합니다.

## Boolean Conditions

PostgreSQL의 boolean 컬럼은 `TRUE` 또는 `FALSE` 기준으로 필터링합니다.

```sql
WHERE boolean_column IS TRUE
WHERE boolean_column IS FALSE
```

`is_active = 1`처럼 숫자로 비교하는 방식은 PostgreSQL boolean 컬럼에는 적합하지 않습니다.

## AND / OR

두 조건을 모두 만족해야 하면 `AND`를 사용합니다.

```sql
WHERE condition_a
  AND condition_b
```

둘 중 하나만 만족해도 되면 `OR`를 사용합니다.

```sql
WHERE condition_a
   OR condition_b
```

`AND`와 `OR`를 함께 사용할 때는 괄호로 의도를 명확하게 묶습니다.

```sql
WHERE (condition_a OR condition_b)
  AND condition_c
```

여러 값 중 하나인지 확인할 때는 `IN`을 사용할 수 있습니다.

```sql
WHERE column_name IN ('A', 'B', 'C')
```

## ORDER BY

`ORDER BY`는 결과 행의 정렬 순서를 정합니다.

```sql
ORDER BY column_name ASC
ORDER BY column_name DESC
```

`ASC`는 오름차순, `DESC`는 내림차순입니다. `ASC`는 기본값이지만, 연습할 때는 의도를 분명히 하기 위해 적어두는 편이 좋습니다.

정렬 기준이 여러 개일 때는 쉼표로 이어 씁니다.

```sql
ORDER BY first_column ASC, second_column DESC
```

## Aggregate Functions

집계 함수는 여러 행을 하나의 값으로 요약합니다.

| Function | Meaning |
|---|---|
| `COUNT(*)` | 행 개수 |
| `SUM(column_name)` | 합계 |
| `AVG(column_name)` | 평균 |
| `MIN(column_name)` | 최솟값 |
| `MAX(column_name)` | 최댓값 |

행 자체의 개수를 세는 의도라면 `COUNT(*)`를 우선 사용합니다. 특정 컬럼을 넣은 `COUNT(column_name)`은 해당 컬럼이 `NULL`이 아닌 행만 셉니다.

평균처럼 그룹별 요약값을 만들 때는 `AVG`와 `GROUP BY`를 함께 사용합니다.

계산식을 먼저 만든 뒤 그룹별로 합산할 수도 있습니다.

```sql
SUM(column_a * column_b)
```

PostgreSQL에서 정수끼리 나누면 정수 나눗셈이 됩니다. 소수점 계산이 필요한 문제라면 `100` 대신 `100.0`처럼 소수 리터럴을 사용합니다.

퍼센트 증가를 적용할 때는 아래처럼 한 번에 곱한 뒤 나누는 편이 안전합니다.

```sql
base_amount * (100 + rate) / 100
```

`base_amount / 100 * rate`처럼 먼저 나누면 정수 나눗셈 때문에 중간값이 잘릴 수 있습니다.

## GROUP BY

그룹별로 집계하려면 `GROUP BY`가 필요합니다.

```sql
SELECT group_column, aggregate_function(value_column)
FROM table_name
GROUP BY group_column
```

`SELECT`에 일반 컬럼과 집계 함수를 함께 쓸 때, 일반 컬럼은 보통 `GROUP BY`에 포함되어야 합니다.

조건에 맞는 값만 그룹 안에서 꺼낼 때는 조건부 집계를 사용할 수 있습니다.

```sql
MAX(CASE WHEN condition THEN value_column END)
```

이때 `MAX`는 최댓값을 찾기 위한 목적보다, 조건에 맞는 하나의 값을 그룹 결과로 꺼내기 위한 도구로 쓰일 수 있습니다.

## HAVING

`HAVING`은 그룹화된 결과를 필터링할 때 사용합니다.

행 단위 조건은 `WHERE`에 쓰고, 집계 결과 조건은 `HAVING`에 씁니다.

```sql
WHERE row_condition
GROUP BY group_column
HAVING aggregate_condition
```

PostgreSQL에서는 `HAVING`에서 `SELECT` 별칭을 바로 쓰기보다 집계식을 다시 적는 편이 안전합니다.

```sql
HAVING SUM(column_name) >= 100000
```

## JOIN

`JOIN`은 두 테이블의 관련 행을 연결할 때 사용합니다.

```sql
FROM table_a AS a
INNER JOIN table_b AS b
  ON a.key_column = b.key_column
```

`ON`에는 두 테이블을 어떤 컬럼으로 연결할지 명확히 적습니다.

두 테이블에 같은 이름의 컬럼이 있거나 컬럼 출처가 헷갈릴 수 있으면 `table_alias.column_name` 형태로 작성합니다.

`JOIN`한 결과를 그룹화할 때도 같은 원칙으로 컬럼 출처를 명확히 적는 편이 좋습니다.

## CASE WHEN

`CASE WHEN`은 조건에 따라 다른 값을 반환합니다.

```sql
CASE
  WHEN condition THEN result_value
END
```

`ELSE`를 쓰지 않으면 조건을 만족하지 않는 행은 `NULL`을 반환합니다.

조건별 합계를 만들 때는 각 행을 먼저 더할 값 또는 0으로 바꾼 뒤 `SUM`으로 합산합니다.

```sql
SUM(CASE WHEN condition THEN amount ELSE 0 END)
```

`END`는 `CASE` 식의 끝을 표시합니다. `SUM` 안에서 사용할 때도 `END`까지 닫아야 하나의 값으로 계산할 수 있습니다.

## Window Functions

윈도우 함수는 행을 유지한 채 그룹 안에서 순위나 누적값을 계산할 때 사용합니다.

그룹 안에서 최신순 번호를 붙일 때는 `ROW_NUMBER()`를 사용할 수 있습니다.

```sql
ROW_NUMBER() OVER (
  PARTITION BY group_column
  ORDER BY sort_column DESC
)
```

`PARTITION BY`는 번호를 매길 그룹을 정하고, `ORDER BY`는 그 그룹 안에서의 순서를 정합니다.

## Common Mistakes

`WHERE`는 한 번만 사용하고, 여러 조건은 `AND`나 `OR`로 연결합니다.

`ORDER BY`는 `GROUP BY` 뒤에 옵니다.

집계 결과를 필터링할 때는 `WHERE`가 아니라 `HAVING`을 사용합니다.

집계 결과를 정렬할 때는 별칭을 사용할 수 있습니다.

`JOIN`의 `ON` 절에는 연결할 두 컬럼의 비교식을 적습니다.

`GROUP BY`는 행을 접는 작업이므로, 최신 행과 두 번째 최신 행처럼 순서가 필요한 값을 찾기 전에는 먼저 순번을 붙입니다.

문제에서 요구한 결과 컬럼명과 정렬 기준을 끝까지 확인합니다.
