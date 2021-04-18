-- Created by James Reinhold (https://jamesreinhold.com)
-- Last modification date: 2021-04-18 09:59:45.032

-- tables
-- Table: account_statement
CREATE TABLE account_statement (
    id int  NOT NULL,
    investor_id int  NOT NULL,
    transaction_type_code char(1)  NOT NULL,
    transaction_amount money  NOT NULL,
    transaction_date date  NOT NULL,
    closing_balance money  NOT NULL,
    CONSTRAINT account_statement_pk PRIMARY KEY (id)
);

-- Table: account_type
CREATE TABLE account_type (
    account_type_code char(1)  NOT NULL,
    account_type_desc varchar(20)  NOT NULL,
    CONSTRAINT account_type_pk PRIMARY KEY (account_type_code)
);

-- Table: bank_account
CREATE TABLE bank_account (
    id int  NOT NULL,
    dwolla_source_link varchar(150)  NULL,
    name varchar(150)  NOT NULL,
    number_ending varchar(4)  NULL,
    plaid_account_id varchar(150)  NULL,
    plaid_token varchar(150)  NULL,
    stripe_bank_id varchar(150)  NULL,
    stripe_connect_bank_id varchar(150)  NULL,
    stripe_token varchar(150)  NULL,
    type varchar(150)  NOT NULL,
    created_date date  NOT NULL,
    modified_date date  NOT NULL,
    CONSTRAINT bank_account_pk PRIMARY KEY (id)
);

-- Table: borrower
CREATE TABLE borrower (
    id int  NOT NULL,
    first_name varchar(50)  NOT NULL,
    last_name varchar(50)  NOT NULL,
    current_address varchar(1000)  NOT NULL,
    permanent_address varchar(1000)  NOT NULL,
    contact_number varchar(20)  NOT NULL,
    date_of_birth date  NOT NULL,
    kyc_complete boolean  NOT NULL DEFAULT false,
    highest_qualification varchar(50)  NULL,
    passout_year date  NULL,
    email_address varchar(150)  NOT NULL,
    phone_number varchar(70)  NULL,
    kyc_status varchar(20)  NOT NULL,
    on_boarding_complete boolean  NULL,
    on_boarding_complete_date date  NOT NULL,
    kyc_submitted boolean  NOT NULL,
    salutation varchar(5)  NULL,
    job_title varchar(20)  NOT NULL,
    social_security_number varchar(20)  NOT NULL,
    place_of_birth varchar(50)  NOT NULL,
    time_zone varchar(50)  NOT NULL,
    joined_date date  NOT NULL,
    modified_date date  NULL,
    stripe_id varchar(150)  NULL,
    stripe_seller_id varchar(150)  NULL,
    pending_cash_balance money  NOT NULL,
    verification_date date  NULL,
    registered_ip_address varchar(20)  NOT NULL,
    country_of_residence varchar(2)  NULL,
    currency_id uuid  NOT NULL,
    CONSTRAINT borrower_pk PRIMARY KEY (id)
);

-- Table: borrower_address
CREATE TABLE borrower_address (
    id int  NOT NULL,
    address_line_1 varchar(150)  NOT NULL,
    address_line_2 varchar(150)  NOT NULL,
    state varchar(150)  NOT NULL,
    city varchar(150)  NOT NULL,
    zip_code varchar(150)  NOT NULL,
    address_type varchar(20)  NOT NULL,
    status varchar(10)  NOT NULL,
    borrower_id int  NOT NULL,
    CONSTRAINT borrower_address_pk PRIMARY KEY (id)
);

-- Table: borrower_asset
CREATE TABLE borrower_asset (
    id int  NOT NULL,
    loan_ticket_id int  NOT NULL,
    asset_type varchar(100)  NOT NULL,
    asset_value decimal(20,2)  NOT NULL,
    ownership_percentage int  NOT NULL,
    possession_since date  NULL,
    CONSTRAINT borrower_asset_pk PRIMARY KEY (id)
);

-- Table: borrower_liability
CREATE TABLE borrower_liability (
    id int  NOT NULL,
    loan_ticket_id int  NOT NULL,
    liability_outstanding money  NOT NULL,
    monthly_repayment_amount decimal(19,2)  NOT NULL,
    liability_type varchar(10)  NOT NULL,
    liability_start_date date  NOT NULL,
    liability_end_date date  NULL,
    CONSTRAINT borrower_liability_pk PRIMARY KEY (id)
);

-- Table: card
CREATE TABLE card (
    id int  NOT NULL,
    card_type varchar(50)  NOT NULL,
    stripe_id varchar(150)  NOT NULL,
    card_ending varchar(4)  NOT NULL,
    created_date date  NOT NULL,
    modified_date date  NOT NULL,
    CONSTRAINT card_pk PRIMARY KEY (id)
);

-- Table: city_locations
CREATE TABLE city_locations (
    id int  NOT NULL,
    name varchar(150)  NOT NULL,
    state_or_region_id int  NOT NULL,
    CONSTRAINT city_locations_pk PRIMARY KEY (id)
);

-- Table: country
CREATE TABLE country (
    id int  NOT NULL,
    name varchar(150)  NOT NULL,
    iso2 varchar(2)  NULL,
    iso3 varchar(3)  NULL,
    currency varchar(3)  NOT NULL,
    CONSTRAINT country_pk PRIMARY KEY (id)
);

-- Table: currency
CREATE TABLE currency (
    id uuid  NOT NULL,
    name varchar(50)  NOT NULL,
    code varchar(3)  NOT NULL,
    created_date date  NOT NULL,
    modified_date date  NOT NULL,
    CONSTRAINT currency_pk PRIMARY KEY (id)
);

-- Table: employment_detail
CREATE TABLE employment_detail (
    id int  NOT NULL,
    borrower_id int  NOT NULL,
    posting_date date  NOT NULL,
    employment_type varchar(50)  NOT NULL,
    profession_type varchar(50)  NOT NULL,
    exp_in_curr_profession_in_yr int  NOT NULL,
    tenure_with_curr_employer int  NULL,
    employment_description varchar(4000)  NULL,
    monthly_salary money  NOT NULL,
    CONSTRAINT employment_detail_pk PRIMARY KEY (id)
);

-- Table: investment
CREATE TABLE investment (
    id int  NOT NULL,
    amount money  NOT NULL,
    date_completed date  NOT NULL,
    date_invested date  NOT NULL,
    grade varchar(1)  NOT NULL,
    rate decimal  NOT NULL,
    share decimal  NOT NULL,
    status varchar(20)  NOT NULL,
    term_months int  NOT NULL,
    total_interest_gained decimal  NOT NULL,
    total_return_amount money  NOT NULL,
    created_date date  NOT NULL,
    modified_date date  NOT NULL,
    investor_id int  NOT NULL,
    loan_grade_id int  NOT NULL,
    CONSTRAINT investment_pk PRIMARY KEY (id)
);

-- Table: investor
CREATE TABLE investor (
    id int  NOT NULL,
    first_name varchar(50)  NOT NULL,
    last_name varchar(50)  NOT NULL,
    tax_id varchar(20)  NOT NULL,
    date_of_birth date  NOT NULL,
    contact_number varchar(20)  NOT NULL,
    kyc_complete char(1)  NOT NULL,
    escrow_account_number varchar(35)  NOT NULL,
    investment_limit money  NOT NULL,
    fund_committed money  NOT NULL,
    CONSTRAINT investor_pk PRIMARY KEY (id)
);

-- Table: investor_proposal
CREATE TABLE investor_proposal (
    id int  NOT NULL,
    investor_id int  NOT NULL,
    loan_ticket_id int  NOT NULL,
    proposal_amount money  NOT NULL,
    proposal_date date  NOT NULL,
    cancel_date date  NULL,
    last_update_date date  NULL,
    CONSTRAINT investor_proposal_pk PRIMARY KEY (id)
);

-- Table: loan
CREATE TABLE loan (
    id int  NOT NULL,
    amount money  NOT NULL,
    application_step int  NOT NULL,
    apr int  NOT NULL,
    balance int  NOT NULL,
    charge_off_date date  NOT NULL,
    current_other_amount money  NOT NULL,
    current_payment_amount money  NOT NULL,
    current_payment_type varchar(150)  NOT NULL,
    current_payoff_amount money  NOT NULL,
    denial_date date  NOT NULL,
    funded varchar(3)  NOT NULL,
    funded_date date  NOT NULL,
    funding_amount money  NOT NULL,
    funding_percentage decimal  NOT NULL,
    interest_balance money  NOT NULL,
    interest_rate decimal  NOT NULL,
    investments int  NOT NULL,
    listed int  NOT NULL,
    listing_end_date date  NOT NULL,
    listing_start_date date  NOT NULL,
    loan_agreement varchar(120)  NOT NULL,
    months_since int  NOT NULL,
    next_monthly_payment_amount int  NOT NULL,
    origination_date date  NOT NULL,
    paid_date date  NOT NULL,
    principal_balance money  NOT NULL,
    purpose int  NOT NULL,
    submitted_date date  NOT NULL,
    status int  NOT NULL,
    term_months int  NOT NULL,
    total_interests decimal  NOT NULL,
    total_interests_paid decimal  NOT NULL,
    total_paid money  NOT NULL,
    total_payments_made money  NOT NULL,
    total_repayment_amount money  NOT NULL,
    verification_stage varchar(120)  NOT NULL,
    created_date date  NOT NULL,
    modified_date date  NOT NULL,
    borrower_id int  NOT NULL,
    payment_id int  NOT NULL,
    CONSTRAINT loan_pk PRIMARY KEY (id)
);

-- Table: loan_grade
CREATE TABLE loan_grade (
    id int  NOT NULL,
    interest_rate decimal  NOT NULL,
    label varchar(50)  NOT NULL,
    min int  NOT NULL,
    max int  NOT NULL,
    created_date date  NOT NULL,
    modified_date date  NOT NULL,
    CONSTRAINT loan_grade_pk PRIMARY KEY (id)
);

-- Table: loan_repayment_schedule
CREATE TABLE loan_repayment_schedule (
    id int  NOT NULL,
    loan_ticket_fulfillment_id int  NOT NULL,
    emi_due_date date  NOT NULL,
    due_interest_amount money  NOT NULL,
    due_principal_amount money  NOT NULL,
    due_emi_amount money  NOT NULL,
    penalty_amount money  NULL,
    total_due_amount money  NOT NULL,
    emi_amount_received money  NOT NULL,
    penalty_amount_received money  NULL,
    receive_date date  NULL,
    is_emi_payment_defaulted char(1)  NULL,
    is_emi_payment_advanced char(1)  NULL,
    CONSTRAINT loan_repayment_schedule_pk PRIMARY KEY (id)
);

-- Table: loan_ticket
CREATE TABLE loan_ticket (
    id int  NOT NULL,
    borrower_id int  NOT NULL,
    loan_amount money  NOT NULL,
    loan_tenure_in_months int  NOT NULL,
    interest_rate money  NOT NULL,
    risk_rating char(1)  NOT NULL,
    reason_for_loan varchar(1000)  NULL,
    ability_to_repay varchar(4000)  NULL,
    risk_factors varchar(4000)  NULL,
    CONSTRAINT loan_ticket_pk PRIMARY KEY (id)
);

-- Table: loan_ticket_fulfillment
CREATE TABLE loan_ticket_fulfillment (
    id int  NOT NULL,
    investor_proposal_id int  NOT NULL,
    release_date_from_investor date  NOT NULL,
    disburse_date_to_borrower date  NOT NULL,
    pre_emi_amount money  NULL,
    pre_emi_due_date date  NULL,
    emi_amount money  NOT NULL,
    emi_start_date date  NOT NULL,
    emi_end_date date  NOT NULL,
    num_of_total_emi int  NOT NULL,
    pre_closure_flag char(1)  NULL,
    pre_closure_date date  NULL,
    last_update_date date  NOT NULL,
    CONSTRAINT loan_ticket_fulfillment_pk PRIMARY KEY (id)
);

-- Table: monthly_payment
CREATE TABLE monthly_payment (
    id uuid  NOT NULL,
    amount money  NOT NULL,
    date date  NOT NULL,
    paid_date date  NOT NULL,
    balance money  NOT NULL,
    interest_balance money  NOT NULL,
    interest_portion money  NOT NULL,
    principal_balance money  NOT NULL,
    principal_portion money  NOT NULL,
    status varchar(20)  NOT NULL,
    created_date date  NOT NULL,
    modified_date date  NOT NULL,
    completed_date date  NOT NULL,
    loan_id int  NOT NULL,
    payment_id int  NOT NULL,
    borrower_id int  NOT NULL,
    CONSTRAINT monthly_payment_pk PRIMARY KEY (id)
);

-- Table: nominee
CREATE TABLE nominee (
    id int  NOT NULL,
    first_name varchar(50)  NOT NULL,
    last_name varchar(50)  NOT NULL,
    date_of_birth date  NOT NULL,
    investor_id int  NOT NULL,
    relationship_with_investor varchar(20)  NOT NULL,
    CONSTRAINT nominee_pk PRIMARY KEY (id)
);

-- Table: page
CREATE TABLE page (
    id uuid  NOT NULL,
    title varchar(150)  NOT NULL,
    slug varchar(150)  NOT NULL,
    headline varchar(150)  NULL,
    content varchar(5000)  NOT NULL,
    meta_keywords varchar(255)  NULL,
    meta_description varchar(250)  NULL,
    created_date date  NOT NULL,
    modified_date date  NOT NULL,
    CONSTRAINT page_pk PRIMARY KEY (id)
);

-- Table: payment
CREATE TABLE payment (
    id int  NOT NULL,
    CONSTRAINT payment_pk PRIMARY KEY (id)
);

-- Table: payment_method
CREATE TABLE payment_method (
    id int  NOT NULL,
    investor_id int  NOT NULL,
    account_number varchar(35)  NOT NULL,
    account_type char(1)  NOT NULL,
    account_holder_name varchar(100)  NOT NULL,
    wire_transfer_code int  NOT NULL,
    bank_name varchar(100)  NOT NULL,
    account_type_code char(1)  NOT NULL,
    CONSTRAINT payment_method_pk PRIMARY KEY (id)
);

-- Table: refund
CREATE TABLE refund (
    id int  NOT NULL,
    CONSTRAINT refund_pk PRIMARY KEY (id)
);

-- Table: state_or_region
CREATE TABLE state_or_region (
    id int  NOT NULL,
    name varchar(150)  NOT NULL,
    iso2 varchar(2)  NULL,
    country varchar(3)  NOT NULL,
    country_id int  NOT NULL,
    CONSTRAINT state_or_region_pk PRIMARY KEY (id)
);

-- Table: team_member
CREATE TABLE team_member (
    id uuid  NOT NULL,
    name varchar(150)  NOT NULL,
    designation varchar(150)  NOT NULL,
    photo varchar(150)  NOT NULL,
    facebook varchar(150)  NULL,
    twitter varchar(150)  NULL,
    linkedlin varchar(150)  NULL,
    created_date date  NOT NULL,
    modified_date date  NOT NULL,
    CONSTRAINT team_member_pk PRIMARY KEY (id)
);

-- Table: transaction_history
CREATE TABLE transaction_history (
    id int  NOT NULL,
    CONSTRAINT transaction_history_pk PRIMARY KEY (id)
);

-- Table: transaction_type
CREATE TABLE transaction_type (
    transaction_type_code char(1)  NOT NULL,
    transaction_type varchar(20)  NOT NULL,
    CONSTRAINT transaction_type_pk PRIMARY KEY (transaction_type_code)
);

-- Table: withdrawal
CREATE TABLE withdrawal (
    id int  NOT NULL,
    amount money  NOT NULL,
    fees money  NOT NULL,
    bank_account_id int  NOT NULL,
    reference varchar(150)  NOT NULL,
    transaction_history_id int  NOT NULL,
    status varchar(20)  NOT NULL,
    modified_date date  NOT NULL,
    created_date date  NOT NULL,
    approved_date date  NOT NULL,
    completed_date date  NOT NULL,
    borrower_id int  NOT NULL,
    CONSTRAINT withdrawal_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: acc_statement_trans_type (table: account_statement)
ALTER TABLE account_statement ADD CONSTRAINT acc_statement_trans_type
    FOREIGN KEY (transaction_type_code)
    REFERENCES transaction_type (transaction_type_code)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: account_statement_investor (table: account_statement)
ALTER TABLE account_statement ADD CONSTRAINT account_statement_investor
    FOREIGN KEY (investor_id)
    REFERENCES investor (id)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: borrower_address_borrower (table: borrower_address)
ALTER TABLE borrower_address ADD CONSTRAINT borrower_address_borrower
    FOREIGN KEY (borrower_id)
    REFERENCES borrower (id)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: borrower_asset_loan_ticket (table: borrower_asset)
ALTER TABLE borrower_asset ADD CONSTRAINT borrower_asset_loan_ticket
    FOREIGN KEY (loan_ticket_id)
    REFERENCES loan_ticket (id)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: borrower_liability_loan_ticket (table: borrower_liability)
ALTER TABLE borrower_liability ADD CONSTRAINT borrower_liability_loan_ticket
    FOREIGN KEY (loan_ticket_id)
    REFERENCES loan_ticket (id)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: city_locations_state_or_region (table: city_locations)
ALTER TABLE city_locations ADD CONSTRAINT city_locations_state_or_region
    FOREIGN KEY (state_or_region_id)
    REFERENCES state_or_region (id)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: default_currency (table: borrower)
ALTER TABLE borrower ADD CONSTRAINT default_currency
    FOREIGN KEY (currency_id)
    REFERENCES currency (id)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: employment_detail_borrower (table: employment_detail)
ALTER TABLE employment_detail ADD CONSTRAINT employment_detail_borrower
    FOREIGN KEY (borrower_id)
    REFERENCES borrower (id)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: investment_investor (table: investment)
ALTER TABLE investment ADD CONSTRAINT investment_investor
    FOREIGN KEY (investor_id)
    REFERENCES investor (id)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: investment_loan_grade (table: investment)
ALTER TABLE investment ADD CONSTRAINT investment_loan_grade
    FOREIGN KEY (loan_grade_id)
    REFERENCES loan_grade (id)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: investor_proposal_investor (table: investor_proposal)
ALTER TABLE investor_proposal ADD CONSTRAINT investor_proposal_investor
    FOREIGN KEY (investor_id)
    REFERENCES investor (id)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: investor_proposal_loan_ticket (table: investor_proposal)
ALTER TABLE investor_proposal ADD CONSTRAINT investor_proposal_loan_ticket
    FOREIGN KEY (loan_ticket_id)
    REFERENCES loan_ticket (id)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: list_of_payments (table: loan)
ALTER TABLE loan ADD CONSTRAINT list_of_payments
    FOREIGN KEY (payment_id)
    REFERENCES payment (id)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: loan_borrower (table: loan)
ALTER TABLE loan ADD CONSTRAINT loan_borrower
    FOREIGN KEY (borrower_id)
    REFERENCES borrower (id)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: loan_repay_sch_loan_tkt_ffl (table: loan_repayment_schedule)
ALTER TABLE loan_repayment_schedule ADD CONSTRAINT loan_repay_sch_loan_tkt_ffl
    FOREIGN KEY (loan_ticket_fulfillment_id)
    REFERENCES loan_ticket_fulfillment (id)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: loan_ticket_borrower (table: loan_ticket)
ALTER TABLE loan_ticket ADD CONSTRAINT loan_ticket_borrower
    FOREIGN KEY (borrower_id)
    REFERENCES borrower (id)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: loan_tkt_ffl_investor_prp (table: loan_ticket_fulfillment)
ALTER TABLE loan_ticket_fulfillment ADD CONSTRAINT loan_tkt_ffl_investor_prp
    FOREIGN KEY (investor_proposal_id)
    REFERENCES investor_proposal (id)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: monthly_payment_borrower (table: monthly_payment)
ALTER TABLE monthly_payment ADD CONSTRAINT monthly_payment_borrower
    FOREIGN KEY (borrower_id)
    REFERENCES borrower (id)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: monthly_payment_loan (table: monthly_payment)
ALTER TABLE monthly_payment ADD CONSTRAINT monthly_payment_loan
    FOREIGN KEY (loan_id)
    REFERENCES loan (id)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: monthly_payment_payment (table: monthly_payment)
ALTER TABLE monthly_payment ADD CONSTRAINT monthly_payment_payment
    FOREIGN KEY (payment_id)
    REFERENCES payment (id)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: nominee_investor (table: nominee)
ALTER TABLE nominee ADD CONSTRAINT nominee_investor
    FOREIGN KEY (investor_id)
    REFERENCES investor (id)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: payment_method_account_type (table: payment_method)
ALTER TABLE payment_method ADD CONSTRAINT payment_method_account_type
    FOREIGN KEY (account_type_code)
    REFERENCES account_type (account_type_code)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: payment_method_investor (table: payment_method)
ALTER TABLE payment_method ADD CONSTRAINT payment_method_investor
    FOREIGN KEY (investor_id)
    REFERENCES investor (id)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: state_or_region_country (table: state_or_region)
ALTER TABLE state_or_region ADD CONSTRAINT state_or_region_country
    FOREIGN KEY (country_id)
    REFERENCES country (id)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: withdrawal_bank_account (table: withdrawal)
ALTER TABLE withdrawal ADD CONSTRAINT withdrawal_bank_account
    FOREIGN KEY (bank_account_id)
    REFERENCES bank_account (id)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: withdrawal_borrower (table: withdrawal)
ALTER TABLE withdrawal ADD CONSTRAINT withdrawal_borrower
    FOREIGN KEY (borrower_id)
    REFERENCES borrower (id)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: withdrawal_transaction_history (table: withdrawal)
ALTER TABLE withdrawal ADD CONSTRAINT withdrawal_transaction_history
    FOREIGN KEY (transaction_history_id)
    REFERENCES transaction_history (id)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- End of file.
