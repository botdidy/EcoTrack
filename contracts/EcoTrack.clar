;; Ecotrack Contract
;; This is a contract that allows users to earn and track solar energy credits

;; Constants
(define-constant ERR-INVALID-USER (err u100))
(define-constant ERR-CREDIT-OVERFLOW (err u101))
(define-constant ERR-INSUFFICIENT-BALANCE (err u102))
(define-constant MAX-CREDITS u340282366920938463463374607431768211455) ;; (2^128 - 1)

;; Define the map to store solar credits for each user
(define-map solar-credits principal uint)

;; Function to earn a solar credit
(define-public (earn-solar-credit)
  (let
    (
      (caller tx-sender)
      (current-credits (default-to u0 (map-get? solar-credits caller)))
    )
    (asserts! (< current-credits MAX-CREDITS) ERR-CREDIT-OVERFLOW)
    (ok (map-set solar-credits caller (+ current-credits u1)))
  )
)

;; Function to get the solar credits for a user
(define-read-only (get-solar-credits (user principal))
  (ok (default-to u0 (map-get? solar-credits user)))
)

;; Function to transfer credits between users
(define-public (transfer-credits (recipient principal) (amount uint))
  (let
    (
      (sender tx-sender)
      (sender-balance (default-to u0 (map-get? solar-credits sender)))
    )
    (asserts! (not (is-eq sender recipient)) ERR-INVALID-USER)
    (asserts! (<= amount sender-balance) ERR-INSUFFICIENT-BALANCE)
    (map-set solar-credits sender (- sender-balance amount))
    (map-set solar-credits recipient (+ (default-to u0 (map-get? solar-credits recipient)) amount))
    (ok true)
  )
)

