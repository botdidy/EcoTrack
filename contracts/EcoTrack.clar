;; Ecotrack Contract
;; This is a contract that allows users to earn, track, and trade solar energy credits

;; Constants
(define-constant ERR-INVALID-USER (err u100))
(define-constant ERR-CREDIT-OVERFLOW (err u101))
(define-constant ERR-INSUFFICIENT-BALANCE (err u102))
(define-constant ERR-UNAUTHORIZED (err u103))
(define-constant ERR-INVALID-AMOUNT (err u104))
(define-constant MAX-CREDITS u340282366920938463463374607431768211455) ;; (2^128 - 1)

;; Define the map to store solar credits for each user
(define-map solar-credits principal uint)

;; Define a map to store the total amount of credits earned by each user
(define-map total-credits-earned principal uint)

;; Define the contract owner
(define-data-var contract-owner (optional principal) (some tx-sender))

;; Function to earn a solar credit
(define-public (earn-solar-credit (amount uint))
  (let
    (
      (caller tx-sender)
      (current-credits (default-to u0 (map-get? solar-credits caller)))
      (total-earned (default-to u0 (map-get? total-credits-earned caller)))
    )
    (asserts! (> amount u0) ERR-INVALID-AMOUNT)
    (asserts! (<= (+ current-credits amount) MAX-CREDITS) ERR-CREDIT-OVERFLOW)
    (map-set solar-credits caller (+ current-credits amount))
    (map-set total-credits-earned caller (+ total-earned amount))
    (ok amount)
  )
)

;; Function to get the solar credits for a user
(define-read-only (get-solar-credits (user principal))
  (ok (default-to u0 (map-get? solar-credits user)))
)

;; Function to get the total credits earned by a user
(define-read-only (get-total-credits-earned (user principal))
  (ok (default-to u0 (map-get? total-credits-earned user)))
)

;; Function to transfer credits between users
(define-public (transfer-credits (recipient principal) (amount uint))
  (let
    (
      (sender tx-sender)
      (sender-balance (default-to u0 (map-get? solar-credits sender)))
    )
    (asserts! (not (is-eq sender recipient)) ERR-INVALID-USER)
    (asserts! (> amount u0) ERR-INVALID-AMOUNT)
    (asserts! (<= amount sender-balance) ERR-INSUFFICIENT-BALANCE)
    (map-set solar-credits sender (- sender-balance amount))
    (map-set solar-credits recipient (+ (default-to u0 (map-get? solar-credits recipient)) amount))
    (ok amount)
  )
)

;; Function to burn credits (e.g., when redeeming for rewards)
(define-public (burn-credits (amount uint))
  (let
    (
      (caller tx-sender)
      (current-credits (default-to u0 (map-get? solar-credits caller)))
    )
    (asserts! (> amount u0) ERR-INVALID-AMOUNT)
    (asserts! (<= amount current-credits) ERR-INSUFFICIENT-BALANCE)
    (map-set solar-credits caller (- current-credits amount))
    (ok amount)
  )
)

;; Function to change the contract owner (only callable by current owner)
(define-public (set-contract-owner (get-contract-owner principal))
  (let
    (
      (current-owner (unwrap! (var-get contract-owner) ERR-UNAUTHORIZED))
    )
    (asserts! (is-eq tx-sender current-owner) ERR-UNAUTHORIZED)
    (var-set contract-owner (some current-owner))
    (ok true)
  )
)

;; Function to get the current contract owner
(define-read-only (get-contract-owner)
  (ok (var-get contract-owner))
)