/* Ticket
 * Author: Tudor
 * Creation date: 1/19/2023
 */
MACHINE
    Ticket
SEES
    String
INCLUDES
    Game, Ticket
OPERATIONS
    cancelGame(game) =
    PRE
        game : games
    THEN
        deleteAllTicketsForAGame(game) || 
        deleteGame(game)
    END
END