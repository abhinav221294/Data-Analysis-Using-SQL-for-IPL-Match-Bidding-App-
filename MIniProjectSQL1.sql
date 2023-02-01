use ipl;

show tables;
select * from ipl_bidder_details;
select * from ipl_bidder_points;
select * from ipl_bidding_details;
select * from ipl_match;
select * from ipl_match_schedule;
select * from ipl_player;
select * from ipl_stadium;
select * from ipl_team;
select * from ipl_team_players;
select * from ipl_team_standings;
select * from ipl_tournament;
select * from ipl_user;





# 1.	Show the percentage of wins of each bidder in the order of highest to lowest percentage.


select bdr_dt.bidder_id,bdr_dt.bidder_name,(
select count(*)
from ipl_bidding_details bid_dt
where bid_dt.bid_status= 'won'
and bid_dt.bidder_id = bdr_dt.bidder_id)/
(select no_of_bids from ipl_bidder_points bdr_pt
 where bdr_pt.bidder_id = bdr_dt.bidder_id)*100 as 'percentage of wins'
 from ipl_bidder_details bdr_dt
 order by 3 desc;


# 2.	Display the number of matches conducted at each stadium with stadium name, city from the database.

select stadium_name,city,ipl_ms.STADIUM_ID,count(ipl_ms.STADIUM_ID) 'number of matches'
from ipl_stadium ipl_s
inner join ipl_match_schedule ipl_ms
on ipl_s.STADIUM_ID = ipl_ms.STADIUM_ID
group by stadium_name,city;


# 3.	In a given stadium, what is the percentage of wins by a team which has won the toss?


select stadium_name,
((
select count(*) from ipl_match m 
inner join ipl_match_schedule ms
on m.match_id = ms.match_id
where ms.stadium_id = s.stadium_id
and 
toss_winner = match_winner
)/ (select count(*) from ipl_match_schedule ms where ms.stadium_id = s.stadium_id))*100 as percentage
from ipl_stadium s;





# 4.	Show the total bids along with bid team and team name.

select bid_team,team_name,count(*)
from ipl_bidding_details ibd
inner join ipl_team it
on 
ibd.bid_team = it.team_id
group by bid_team,team_name;

# 5.	Show the team id who won the match as per the win details.alter

select distinct win_details,match_winner
from ipl_match;

# 6.	Display total matches played, total matches won and total matches lost by team along with its team name.

select * from
ipl_match;

select * from ipl_team;
  
 select * from ipl_team_standings; 
  
 select team_name,sum(MATCHES_PLAYED),sum(MATCHES_WON),sum(MATCHES_LOST)
 from ipl_team_standings its
 inner join 
 ipl_team it
 on its.team_id = it.team_id
 group by team_name;

# 7.	Display the bowlers for Mumbai Indians team.



select PLAYER_NAME
from ipl_team_players itp
inner join 
ipl_player ip
on itp.player_id = ip.player_id
inner join ipl_team it 
on itp.team_id = it.team_id
where player_role = 'Bowler'
and team_name = 'Mumbai Indians';


# 8.	How many all-rounders are there in each team, Display the teams with more than 4 
# all-rounder in descending order.


select * from ipl_team_players;
select * from ipl_player;

select * from ipl_team;

select team_name,count(*) as number_of_all_rounder,it.team_id
from ipl_team it
inner join 
ipl_team_players itp
on it.team_id = itp.team_id
inner join 
ipl_player ip
on itp.player_id = ip.player_id
where player_role = 'All-Rounder'
group by team_name,it.team_id
having number_of_all_rounder > 4
order by team_name,number_of_all_rounder,it.team_id;

