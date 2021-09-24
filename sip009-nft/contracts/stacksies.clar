;;(impl-trait 'SP...contract-name.trait-identifier)

(impl-trait .sip009-nft-trait.sip009-nft-trait)

(define-non-fungible-token stacksies uint)

(define-constant contract-owner tx-sender)
(define-constant err-not-token-owner (err u100))
(define-constant err-not-contract-owner (err u101))

(define-data-var last-token-id uint u0)

(define-read-only (get-last-token-id)   
    (ok (var-get last-token-id))
)

(define-read-only (get-token-uri (token-id uint)) 
    (ok none)
)

(define-read-only (get-owner (token-id uint))
    (ok (nft-get-owner? stacksies token-id))
)

(define-public (transfer (token-id uint) (sender principal) (recipient principal)) 
    (begin 
        (asserts! (is-eq tx-sender sender) err-not-token-owner)
        (nft-transfer? stacksies token-id sender recipient) 
    )
)

(define-public (mint (recipient principal)) 

    (let
        ;;variable expressions
        (
            (token-id (+ (var-get last-token-id) u1))

        ) 
        
        ;; inner expressions   
        (asserts! (is-eq tx-sender contract-owner) err-not-contract-owner)
        (try! (nft-mint? stacksies token-id recipient))
        (var-set last-token-id token-id)    
        (ok true)
    )

)

;;(nft-mint? stacksies u0 tx-sender)


;; Test it: 
;; -------------
;; clarinet check
;; clarinet console
;; 
;; (contract-call? 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM.stacksies get-owner u0
;; tx-sender
;; (contract-call? 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM.stacksies transfer u0 tx-sender 'STNHKEPYEPJ8ET55ZZ0M5A34J0R3N5FM2CMMMAZ6
;; ::get_assets_maps
;; (contract-call? 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM.stacksies transfer u0 'STNHKEPYEPJ8ET55ZZ0M5A34J0R3N5FM2CMMMAZ6 tx-sender
;; (contract-call? 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM.stacksies mint tx-sender
;; ::get_assets_maps
;; (contract-call? 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM.stacksies get-last-token-id
;; (contract-call? 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM.stacksies get-owner u3
;; ::set_tx_sender STNHKEPYEPJ8ET55ZZ0M5A34J0R3N5FM2CMMMAZ6
;; (contract-call? 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM.stacksies mint tx-sender  ;; error 101

