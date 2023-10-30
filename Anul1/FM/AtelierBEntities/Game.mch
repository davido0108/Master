/* Game
 * Author: Tudor
 * Creation date: 1/19/2023
 */
MACHINE
    Game
SEES
    String
SETS
    GAME ; SITUATION = {PRECOVID, COVID, POSTCOVID}
ABSTRACT_CONSTANTS
    allowancePercentage
PROPERTIES
    allowancePercentage : SITUATION --> NATURAL1 &
    allowancePercentage = {PRECOVID |-> 100, COVID |-> 50, POSTCOVID |-> 75}
INCLUDES
    Stadium
PROMOTES
    deleteStadium
VARIABLES
    games,
    gameId,
    gameAllowedCapacity,
    gameStadium,
    gameSituation,
    gameAttendance
INVARIANT
    games <: GAME &
    gameId : games >->NATURAL1 &
    gameAllowedCapacity : games >-> NATURAL1 &
    gameStadium : games --> stadiums &
    gameSituation : games --> SITUATION &
    gameAttendance : games >-> NATURAL1 &
    ! gm . (gm :games => gameAllowedCapacity(gm) <= allowancePercentage(gameSituation(gm))*stadiumCapacity(gameStadium(gm))/100) &
    ! gm . (gm :games => gameAttendance(gm) <= gameAllowedCapacity(gm))
INITIALISATION
    games,
    gameId,
    gameAllowedCapacity,
    gameStadium,
    gameSituation,
    gameAttendance:= {},{},{},{},{},{}
OPERATIONS
    newGame <-- createGame(allowedCapacity,stadium,situation) =
    PRE
        allowedCapacity : NATURAL1 &
        stadium : stadiums &
        situation : SITUATION
    THEN
        ANY newG
        WHERE newG : GAME - games
        THEN
            IF allowedCapacity <= allowancePercentage(situation)*stadiumCapacity(stadium)/100 
            THEN
                games := games \/ {newG} ||
                ANY newGId
                WHERE 
                    newGId : NATURAL1 &
                    newGId /: ran(gameId)
                THEN
                    gameId(newG) := newGId
                END ||
                gameAllowedCapacity(newG) := allowedCapacity ||
                gameStadium(newG) := stadium ||
                gameSituation(newG) := situation ||
                gameAttendance(newG) := 0 ||
                newGame := newG
            END
            
        END
    END;
    
    returnGameId <-- getGameId(game) =
    PRE
        game : games
    THEN
        returnGameId := gameId(game)
    END;
    returnGameAllowedCapacity <-- getGameAllowedCapacity(game) =
    PRE
        game : games
    THEN
        returnGameAllowedCapacity := gameAllowedCapacity(game)
    END;
    returnGameStadium <-- getGameStadium(game) =        
    PRE
        game : games
    THEN
        returnGameStadium := gameStadium(game)
    END;
    returnGameSituation <-- getGameSituation(game) =        
    PRE
        game : games
    THEN
        returnGameSituation := gameSituation(game)
    END;
    returnGameAttendance <-- getGameAttendance(game) =        
    PRE
        game : games
    THEN
        returnGameAttendance := gameAttendance(game)
    END;
    
    setGameAllowedCapacity(game, allowedCapacity) = 
    PRE
        game : games &
        allowedCapacity : NATURAL1 &
        allowedCapacity <= allowancePercentage(gameSituation(game))*stadiumCapacity(gameStadium(game))/100
    THEN
        gameAllowedCapacity(game) := allowedCapacity
    END;
    setGameStadium(game, stadium) = 
    PRE
        game : games &
        stadium : stadiums
    THEN
        gameStadium(game) := stadium
    END;
    setGameSituation(game, situation) = 
    PRE
        game : games &
        situation : SITUATION
    THEN
        gameSituation(game) := situation
    END;
    increaseGameAttendance(game) =
    PRE
        game : games
    THEN
	IF 
            gameAttendance(game)<gameAllowedCapacity(game)
        THEN
            gameAttendance(game) := gameAttendance(game) + 1
        END
    END;
    
    deleteGame(game) =
    PRE
        game : games
    THEN
        games := games - {game} ||
        gameId := {game} <<| gameId ||
        gameAllowedCapacity := {game} <<| gameAllowedCapacity ||
        gameStadium := {game} <<| gameStadium ||
        gameSituation := {game} <<| gameSituation ||
        gameAttendance := {game} <<| gameAttendance
    END;
    
    deleteAllGamesForStadium(stadium)=
    PRE
        stadium : stadiums
    THEN
        games := games - gameStadium ~ [{stadium}] ||
        gameId := gameStadium ~ [{stadium}] <<| gameId ||
        gameAllowedCapacity := gameStadium ~ [{stadium}] <<| gameAllowedCapacity ||
        gameSituation := gameStadium ~ [{stadium}] <<| gameSituation ||
        gameAttendance := gameStadium ~ [{stadium}] <<| gameAttendance ||
        gameStadium := gameStadium |>> {stadium}
    END
END
