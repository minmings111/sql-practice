# PostgreSQL Syntax Notes

PostgreSQL로 데이터 분석 쿼리를 작성할 때 자주 쓰는 문법과 헷갈렸던 포인트를 정리합니다.

이 파일은 풀이 쿼리를 저장하는 곳이 아닙니다. 실제 연습 쿼리는 각 `.sql` 파일에서 관리하고, 이 파일에서는 문법 자체와 작성할 때의 기준만 정리합니다.

## Practice File Links

| Topic | Files |
|---|---|
| 전체 조회와 컬럼 선택 | [00](./00_points_select_all.sql), [01](./01_points_select_xy.sql) |
| 조건 필터링과 정렬 | [02](./02_points_filter_i_order_y.sql), [03](./03_points_filter_ii_order_x.sql), [04](./04_points_filter_iii_order_y_desc.sql), [05](./05_points_filter_iv_order_id_desc.sql) |
| 여러 조건 조합 | [06](./06_points_filter_i_y_gte_8.sql), [07](./07_points_filter_ii_x_gt_10.sql), [08](./08_points_filter_iii_y_lt_7_select_columns.sql) |
| 여러 값 조건 | [09](./09_points_filter_i_or_iv_order.sql), [10](./10_points_todo_i_or_ii_y_gt_8.sql) |
| 집계와 그룹화 | [11](./11_orders_count_by_customer.sql), [12](./12_payments_total_by_user.sql), [13](./13_reviews_todo_avg_rating.sql) |

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

## GROUP BY

그룹별로 집계하려면 `GROUP BY`가 필요합니다.

```sql
SELECT group_column, aggregate_function(value_column)
FROM table_name
GROUP BY group_column
```

`SELECT`에 일반 컬럼과 집계 함수를 함께 쓸 때, 일반 컬럼은 보통 `GROUP BY`에 포함되어야 합니다.

## Common Mistakes

`WHERE`는 한 번만 사용하고, 여러 조건은 `AND`나 `OR`로 연결합니다.

`ORDER BY`는 `GROUP BY` 뒤에 옵니다.

집계 결과를 정렬할 때는 별칭을 사용할 수 있습니다.

문제에서 요구한 결과 컬럼명과 정렬 기준을 끝까지 확인합니다.
