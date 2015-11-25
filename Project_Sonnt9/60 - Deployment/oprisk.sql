ALTER TABLE `users` MODIFY COLUMN `fullname` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL;
INSERT
INTO users(
	id,
  version,
	account_expired,
	account_locked,
	branch_id,
	enabled,
	fullname,
	last_login,
	last_logout,
	pass,
	password_expired,
	prop1,
	prop2,
	prop3,
	username
)
(SELECT a.id,0,
      false,
      false,
      NULL,
      true,
      a.name,
      NULL,
	    NULL,
	    '',
	    false,
	    NULL,
	    a.branch,
	    NULL,
	    a.login
    FROM employee a WHERE a.id !='1' and (a.branch is not null or a.role =200)

  );
  
Update users Set prop1 = 1 where id !='1' && id in (Select e.id from employee e where e.role!=200 and e.id !='1');

Update users Set prop1 = 2 where prop2 like '%KHDN%';

Update users Set prop1 = 3 where prop2 like '%DSF%';

update survey set department_id = 1;

Update survey Set department_id = 2 where title like '%KHDN%';

Update survey Set department_id = 3 where title like '%DSF%';

INSERT
INTO user_role(
  role_id,
  user_id
)
(Select
  3,
  a.id
  FROM users a where a.id !='1'
);

update user_role set role_id = 2 where user_id in (Select e.id from employee e where e.role=200 and e.id !='1');
