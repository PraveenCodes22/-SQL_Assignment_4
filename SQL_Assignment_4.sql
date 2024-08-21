--1
create database SubhanuTech
use SubhanuTech

create table Campers(
	CamperId int primary key identity(1,1),
	FirstName varchar(50),
	MiddleName varchar(50),
	LastName varchar(50),
	DateOfBirth date,
	Gender varchar(50),
	Phone varchar(20),
	Email varchar(100)
);
create table Camps(
	CampId int primary key identity(10,1),
	CampTitle varchar(50),
	Capacity int,
	StartDate date,
	EndDate date,
	Price decimal(10,2)
);

Create table CampVisits(
	VisitId int primary key identity(100,1),
	CamperId int,
	CampId  int,
	VisitDate date,
	foreign key(CamperId) references Campers(CamperId),
	foreign key(CampId) references Camps(CampId)

);

with CTE as (select CamperId 
from Campers
where FirstName = 'Lakshmi' )
select count(*) from 
CampVisits cv
join
CTE
on cv.CamperId = cte.CamperId
join
Camps c
on c.CampId = cv.CampId
where cv.VisitDate between c.StartDate and c.EndDate;


--3)
Create table Generations(
	Generation nvarchar(50),
	Gender varchar(10),
	Percentage decimal(4,2)
);
insert into Generations(Generation, Gender, Percentage)
values('Gen X','Male', 55),
		('Gen X', 'Female',45 ),
		('Millenials', 'Male', 46),
		('Millenials', 'Female', 54),
		('Gen Z','Male', 64),
		('Gen Z','Female', 36),
		('Gen Alpha','Male', 64),
		('Gen Alpha','Female', 36);

select Generation,
		max(case when Gender = 'male' then Percentage end) as male_percentage,
		max(case when Gender = 'Female' then Percentage end) as female_percentage
from
	Generations
	group by Generation;


--2)
create table People (
    Age int,
    Gender varchar(10)
	);

declare @TotalPeople int = 5000
declare @TotalGirls int = @TotalPeople * 0.65
declare @TotalBoys int = @TotalPeople * 0.35
declare @Age7to12 int = @TotalPeople * 0.18
declare @Age13to14 int = @TotalPeople * 0.27
declare @Age15to17 int = @TotalPeople * 0.20
declare @Age18to19 int = @TotalPeople - (@Age7to12 + @Age13to14 + @Age15to17);

insert into People(Age, Gender)
select
    case 
        when rn <= @Age7to12 then round(rand() * 5 + 7,0)    
        when rn <= @Age7to12 + @Age13to14 then round(rand() * 2 + 13,0) 
        when rn <= @Age7to12 + @Age13to14 + @Age15to17 then round(rand() * 3 + 15,0)
        else round(rand() * 2 + 18, 0)  
    end as Age,
    'Female' as Gender
from
(
    select top(@TotalGirls) row_number() over(order by newid()) as rn
    from ProjectPortfolio.dbo.CovidVaccinations$
)as Data;

insert into People(Age, Gender)
select 
    case
        when rn <= @Age7to12 then round(rand() * 5 + 7,0)   
        when rn <= @Age7to12 + @Age13to14 then round(rand() * 2 + 13,0) 
        when rn <= @Age7to12 + @Age13to14 + @Age15to17 then round(rand() * 3 + 15,0) 
        else  round(rand() * 2 + 18,0)  
    end as Age,
    'Male' as Gender
from
(
    select top (@TotalBoys) row_number() over(order by newid()) as rn
    from ProjectPortfolio.dbo.CovidVaccinations$
) as Data;
