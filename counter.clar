;; clarinet new myproject
;; clarinet contract new counter

(define-constant contract-owner tx-sender)

(define-data-var counter uint u0)

(define-read-only (get-count) 
    (var-get counter)
)

(define-public (count-up) 
    (begin
        (asserts! (is-eq tx-sender contract-owner) (err false))
        (ok (var-set counter (+ (get-count) u1)))
    )
)

;; (contract-call? 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM.counter count-up)
;; (contract-call? 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM.counter get-count)

