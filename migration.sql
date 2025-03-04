set echo off
clear screen

--Users
insert into users
  select distinct
    user_id,
    surname1||surname2||name,
    passport,
    to_date(birthdate, 'DD-MM-YYYY'),
    null,
    substr(address, 1, instr(address, ',', 1, 2)),
    email,
    phone
  from fsdb.loans
  where
    birthdate != '29-02-1970'
    ;


--Editions
insert into editions
  select distinct
    isbn,
    publisher,
    main_language,
    other_language,
    to_date(pub_date, 'YYYY'),
    extension,
    series,
    pub_country,
    dimensions,
    other_authors
  from fsdb.acervus
   ;

--Books
insert into books
  select distinct
    title,
    alt_title,
    main_author,
    other_authors,
    edition,
    signature,
    to_date(pub_date, 'YYYY'),
    notes
  from fsdb.acervus
  ;

--Loans
insert into loan(loanId, copy)
  select distinct
    null,
    signature,
  from fsdb.acervus
  where
    and signature is not null
and insert into loan(users, loanDate, ReturnDate)
  select distinct
    user_id,
    to_date(date_time, 'DD-MM-YYYY'),
    to_date(return,  'DD-MM-YYYY')
  from fsdb.loans
;


--Sanction
insert into sanction(users)
  select distinct
    user_id
  from fsdb.loans
;

--Comments
insert into comments(users, text)
  select distinct
    user_id,
    post
  from fsdb.loans
;

--Bibus
insert into bibus
  select distinct
    plate,
    route_id
    to_date(last_itv, 'DD-MM-YYYY // HH24:MI:SS'),
    to_date(next_itv, 'DD-MM-YYYY // HH24:MI:SS')
  from fsdb.busstops
;

--Drive
insert into driver
  select distinct
    lib_fullname,
    lib_passport,
    lib_phone,
    lib_email,
    to_date(cont_start, 'DD-MM-YYYY'),
    to_date(cont_end, 'DD-MM-YYYY'),
    null,
    null
  from fsdb.busstops
  ;

--Routes
insert into Routes
  select distinct
  route_id,
  to_date(stopdate, 'DD-MM-YYYY')
  from fsdb.busstops
;

insert into municipality
  select 
    town,
    population,
    has_library
  from fsdb.busstops
  ;

insert into municipal_library
select distinct
    user_id,
    name,
    to_date(birthdate,'DD-MM-YYYY'),
    null,
    address,
    email,
    phone
  from fsdb.loans
  where name like 'Biblioteca%' 
;

insert into route_municipality
  select
    route_id,
    town
  from fsdb.busstops
;

insert into bibus_route
  select distinct
    plate,
    route_id
  from fsdb.busstops
;


  
  




    


