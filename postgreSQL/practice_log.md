# PostgreSQL SQL Practice Log

기준 DB: PostgreSQL

문자열은 작은따옴표를 사용한다.

```sql
WHERE status = 'completed'
```

SQL 기본 작성 순서:

```sql
SELECT
FROM
WHERE
GROUP BY
HAVING
ORDER BY
```

---

## 0. 모든 데이터 조회하기

테이블명: `points`

`points` 테이블의 모든 데이터를 조회한다.

정답:

```sql
SELECT *
FROM points;
```

---

## 0-1. 특정 컬럼만 조회하기

테이블명: `points`

`points` 테이블에서 `x`, `y` 컬럼만 조회한다.

정답:

```sql
SELECT x, y
FROM points;
```

---

## 0-2. 조건에 맞는 모든 컬럼 조회 후 정렬하기

테이블명: `points`

`quartet` 컬럼의 값이 `I`인 데이터만 조회하고, `y` 컬럼 기준으로 오름차순 정렬한다.

정답:

```sql
SELECT *
FROM points
WHERE quartet = 'I'
ORDER BY y ASC;
```

---

## 1. 조건 필터링 후 정렬하기

테이블명: `points`

`quartet` 컬럼의 값이 `II`인 데이터만 조회하고, `x` 컬럼 기준으로 오름차순 정렬한다.

정답:

```sql
SELECT *
FROM points
WHERE quartet = 'II'
ORDER BY x ASC;
```

---

## 2. 조건 필터링 후 내림차순 정렬하기

테이블명: `points`

`quartet` 컬럼의 값이 `III`인 데이터만 조회하고, `y` 컬럼 기준으로 내림차순 정렬한다.

정답:

```sql
SELECT *
FROM points
WHERE quartet = 'III'
ORDER BY y DESC;
```

---

## 3. 조건 필터링 후 id 기준 내림차순 정렬하기

테이블명: `points`

`quartet` 컬럼의 값이 `IV`인 데이터만 조회하고, `id` 컬럼 기준으로 내림차순 정렬한다.

정답:

```sql
SELECT *
FROM points
WHERE quartet = 'IV'
ORDER BY id DESC;
```

---

## 4. 조건 2개를 모두 만족하는 데이터 조회하기

테이블명: `points`

`quartet` 컬럼의 값이 `I`이고, `y` 컬럼의 값이 `8` 이상인 데이터만 조회한다.

모든 컬럼을 조회하고, `x` 컬럼 기준으로 오름차순 정렬한다.

정답:

```sql
SELECT *
FROM points
WHERE quartet = 'I'
  AND y >= 8
ORDER BY x ASC;
```

---

## 5. 조건 2개를 모두 만족하는 데이터 조회 후 내림차순 정렬하기

테이블명: `points`

`quartet` 컬럼의 값이 `II`이고, `x` 컬럼의 값이 `10` 초과인 데이터만 조회한다.

모든 컬럼을 조회하고, `y` 컬럼 기준으로 내림차순 정렬한다.

정답:

```sql
SELECT *
FROM points
WHERE quartet = 'II'
  AND x > 10
ORDER BY y DESC;
```

---

## 6. 조건에 맞는 데이터에서 특정 컬럼만 조회하기

테이블명: `points`

`quartet` 컬럼의 값이 `III`이고, `y` 컬럼의 값이 `7` 미만인 데이터의 `id`, `x`, `y` 컬럼만 조회한다.

`id` 컬럼 기준으로 오름차순 정렬한다.

정답:

```sql
SELECT id, x, y
FROM points
WHERE quartet = 'III'
  AND y < 7
ORDER BY id ASC;
```

---

## 7. 여러 값 중 하나에 해당하는 데이터 조회하기

테이블명: `points`

`quartet` 컬럼의 값이 `I` 또는 `IV`인 데이터만 조회한다.

모든 컬럼을 조회하고, `quartet` 컬럼 기준으로 오름차순 정렬한 뒤, 같은 `quartet` 안에서는 `id` 컬럼 기준으로 오름차순 정렬한다.

정답:

```sql
SELECT *
FROM points
WHERE quartet = 'I'
   OR quartet = 'IV'
ORDER BY quartet ASC, id ASC;
```

같은 의미로 `IN`을 사용할 수도 있다.

```sql
SELECT *
FROM points
WHERE quartet IN ('I', 'IV')
ORDER BY quartet ASC, id ASC;
```

---

## 8. 여러 값 조건과 숫자 조건을 함께 사용하기

테이블명: `points`

`quartet` 컬럼의 값이 `II` 또는 `III`인 데이터 중, `x` 컬럼의 값이 `10` 이상인 데이터만 조회한다.

`id`, `quartet`, `x` 컬럼만 조회하고, `x` 컬럼 기준으로 내림차순 정렬한다.

정답:

```sql
SELECT id, quartet, x
FROM points
WHERE (quartet = 'II' OR quartet = 'III')
  AND x >= 10
ORDER BY x DESC;
```

같은 의미로 `IN`을 사용할 수도 있다.

```sql
SELECT id, quartet, x
FROM points
WHERE quartet IN ('II', 'III')
  AND x >= 10
ORDER BY x DESC;
```

---

## 9. 미풀이

테이블명: `points`

`quartet` 컬럼의 값이 `I` 또는 `II`이고, `y` 컬럼의 값이 `8` 초과인 데이터만 조회한다.

`id`, `quartet`, `y` 컬럼만 조회하고, `quartet` 컬럼 기준으로 오름차순 정렬한 뒤, 같은 `quartet` 안에서는 `y` 컬럼 기준으로 내림차순 정렬한다.

정답: 아직 풀이 전

---

## 10. 고객별 주문 개수 구하기

테이블명: `orders`

| 컬럼명 | 타입 | 설명 |
|---|---|---|
| `order_id` | integer | 주문 ID |
| `customer_id` | integer | 고객 ID |
| `status` | text | 주문 상태 |
| `amount` | integer | 주문 금액 |
| `ordered_at` | date | 주문일 |

`orders` 테이블에서 주문 상태가 `completed`인 주문만 대상으로, 고객별 주문 개수를 조회한다.

결과 컬럼:

| 컬럼명 |
|---|
| `customer_id` |
| `order_count` |

주문 개수가 많은 고객부터 조회하고, 주문 개수가 같으면 `customer_id` 기준으로 오름차순 정렬한다.

정답:

```sql
SELECT customer_id, COUNT(customer_id) AS order_count
FROM orders
WHERE status = 'completed'
GROUP BY customer_id
ORDER BY order_count DESC, customer_id ASC;
```

보통은 아래처럼 `COUNT(*)`를 쓰는 것이 더 일반적이다.

```sql
SELECT customer_id, COUNT(*) AS order_count
FROM orders
WHERE status = 'completed'
GROUP BY customer_id
ORDER BY order_count DESC, customer_id ASC;
```

---

## 11. 사용자별 총 결제 금액 구하기

테이블명: `payments`

| 컬럼명 | 타입 | 설명 |
|---|---|---|
| `payment_id` | integer | 결제 ID |
| `user_id` | integer | 사용자 ID |
| `method` | text | 결제 수단 |
| `amount` | integer | 결제 금액 |
| `paid_at` | date | 결제일 |

`payments` 테이블에서 결제 수단이 `card`인 결제만 대상으로, 사용자별 총 결제 금액을 조회한다.

결과 컬럼:

| 컬럼명 |
|---|
| `user_id` |
| `total_amount` |

총 결제 금액이 큰 사용자부터 조회하고, 총 결제 금액이 같으면 `user_id` 기준으로 오름차순 정렬한다.

정답:

```sql
SELECT user_id, SUM(amount) AS total_amount
FROM payments
WHERE method = 'card'
GROUP BY user_id
ORDER BY total_amount DESC, user_id ASC;
```

---

## 12. 미풀이

테이블명: `reviews`

| 컬럼명 | 타입 | 설명 |
|---|---|---|
| `review_id` | integer | 리뷰 ID |
| `product_id` | integer | 상품 ID |
| `user_id` | integer | 사용자 ID |
| `rating` | integer | 평점 |
| `created_at` | date | 리뷰 작성일 |

`reviews` 테이블에서 상품별 평균 평점을 조회한다.

결과 컬럼:

| 컬럼명 |
|---|
| `product_id` |
| `avg_rating` |

평균 평점이 높은 상품부터 조회하고, 평균 평점이 같으면 `product_id` 기준으로 오름차순 정렬한다.

정답: 아직 풀이 전

---

## 자주 틀린 포인트

### 1. SQL 절 순서

틀린 예:

```sql
SELECT *
WHERE quartet = 'II'
FROM points;
```

맞는 예:

```sql
SELECT *
FROM points
WHERE quartet = 'II';
```

### 2. 비교 연산자

PostgreSQL에서 같은지 비교할 때는 `=`를 사용한다.

```sql
WHERE quartet = 'II'
```

`==`가 아니다.

### 3. 문자열 따옴표

PostgreSQL에서 문자열은 작은따옴표를 사용한다.

```sql
WHERE status = 'completed'
```

쌍따옴표는 컬럼명이나 테이블명 같은 식별자에 쓰인다.

### 4. `WHERE`는 한 번만 쓴다

틀린 예:

```sql
WHERE quartet = 'I'
AND WHERE y >= 8
```

맞는 예:

```sql
WHERE quartet = 'I'
  AND y >= 8
```

### 5. `AND`와 `OR`를 함께 쓸 때는 괄호를 의식한다

```sql
WHERE (quartet = 'II' OR quartet = 'III')
  AND x >= 10
```

### 6. 그룹별 집계는 `GROUP BY`가 필요하다

```sql
SELECT customer_id, COUNT(*) AS order_count
FROM orders
GROUP BY customer_id;
```

### 7. 자주 쓰는 집계 함수

```sql
COUNT(*)      -- 행 개수
SUM(amount)  -- 합계
AVG(rating)  -- 평균
MIN(value)   -- 최솟값
MAX(value)   -- 최댓값
```
