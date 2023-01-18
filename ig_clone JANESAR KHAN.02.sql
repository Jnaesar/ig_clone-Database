--  MANDATORY PROJECT , BY JANESAR KHAN
-- ig_clone dataset
use ig_clone ;

-- Question no. 02
-- We want to reward the user who has been around the longest, Find the 5 oldest users.

select *, datediff(now(), created_at)as days from users
order by created_at
limit 5 ;


-- Question no.03
-- To understand when to run the ad campaign, figure out the day of the week most users register on? 

select dayname(created_at) as Day, count(*) as Total from users
group by day
order by total desc
limit 1 ;

-- Question no. 04
-- To target inactive users in an email ad campaign, find the users who have never posted a photo.

select username from users u
left join photos p on u.id=p.user_id
where p.user_id is null ;


-- Question no. 05
-- suppose you are running a contest to find out who got the most likes on a single photo. Find out who won?

select u.username, p.id, p.image_url, count(*) as total from photos p
inner join likes l on l.photo_id=p.id
inner join users u on p.user_id=u.id
group by p.id
order by total desc 
limit 1 ;


-- Question no.06
-- The investors want to know how many times does the average user post.

select (select count(*) from photos) /
(select count(*) from users) as avg_posts ;


-- Question no. 07
-- A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags.

select t.tag_name, count(*) as hasetag from tags t 
inner join photo_tags pt on pt.tag_id=t.id
group by pt.tag_id
order by hasetag desc
limit 5;


-- Question .no 08
-- To find out if there are bots, find users who have liked every single photo on the site.

create view boats
as
(
with cte as

select username, count(*) as num_likes from users u
inner join likes l on u.id=l.user_id
group by l.user_id ;




-- Question no. 09
-- To know who the celebrities are, find users who have never commented on a photo.

select username as Celebraties from users
where id not in (select user_id from comments) ;



-- Question no. 10
-- Now it's time to find both of them together, find the users who have never commented on any photo or have commented on every photo.
drop view if exists temp ;
create view temp
as
(
select count(user_id) as no_ofcomments, user_id from comments	
 group by user_id
 having count(user_id)= (select count(*) from photos)
 );
 select distinct(username) from users u 
 inner join temp t on t.user_id=u.id
 union
 (select username from users where id not in (select user_id from comments)) ;


select count(*) from photos ;  select * from comments ;























































