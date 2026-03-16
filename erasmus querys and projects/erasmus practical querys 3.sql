-- View 1: Consolidates Movie details with Director names.
-- This view joins two tables: dbo.Movies and dbo.Directors.
-- Purpose: To easily see which director made which movie without writing a JOIN every time.

CREATE VIEW vw_MovieDirectorDetails AS
SELECT
    m.MovieID,
    m.Title AS MovieTitle,
    m.ReleaseYear,
    m.Genre,
    d.DirectorName,
    d.Nationality
FROM
    dbo.Movies AS m
JOIN
    dbo.Directors AS d ON m.DirectorID = d.DirectorID;
GO


-- View 2: Consolidates Actor, Movie, and Role names.
-- This view joins three tables: dbo.Actors, dbo.MovieActors, and dbo.Movies.
-- Purpose: To easily find which actors were in which movies and what their roles were,
-- simplifying a complex three-table join.

CREATE VIEW vw_ActorMovieRoles AS
SELECT
    a.ActorName,
    m.Title AS MovieTitle,
    ma.RoleName,
    a.BirthYear AS ActorBirthYear
FROM
    dbo.Actors AS a
JOIN
    dbo.MovieActors AS ma ON a.ActorID = ma.ActorID
JOIN
    dbo.Movies AS m ON ma.MovieID = m.MovieID;
GO



-- Query 1: Use the first view (vw_MovieDirectorDetails)
-- Goal: Find all movies directed by Christopher Nolan.
-- Notice how simple this is. We don't need a JOIN.

SELECT MovieTitle, ReleaseYear, Genre
FROM vw_MovieDirectorDetails
WHERE DirectorName = 'Christopher Nolan';
GO


-- Query 2: Use the second view (vw_ActorMovieRoles)
-- Goal: Find all actors and their roles in the movie 'Inception'.
-- Again, this is very simple. The complex 3-table JOIN
-- is hidden inside the view.

SELECT ActorName, RoleName
FROM vw_ActorMovieRoles
WHERE MovieTitle = 'Inception';
GO
