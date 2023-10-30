/* Ticket
 * Author: Tudor
 * Creation date: 1/19/2023
 */
MACHINE
    Ticket
SEES
    String
SETS
    TICKET; SECTOR = { SA, SB, SC, SD}
PROMOTES
    deleteGame
CONSTANTS
    minPrice,
    maxPrice
PROPERTIES
    minPrice : SECTOR --> NATURAL1 &
    minPrice = { SA |-> 20, SB |-> 50, SC |-> 100, SD |-> 300} &
    maxPrice : SECTOR --> NATURAL1 &
    maxPrice = { SA |-> 30, SB |-> 70, SC |-> 200, SD |-> 500}
INCLUDES
    Game, Fan
VARIABLES
    tickets,
    ticketId,
    ticketSector,
    ticketPrice,
    ticketFan,
    ticketGame
INVARIANT
    tickets <: TICKET &
    ticketId : tickets --> NATURAL1 &
    ticketSector : tickets --> SECTOR &
    ticketPrice : tickets --> NATURAL1 &
    ticketFan : tickets --> fans &
    ticketGame : tickets --> games
INITIALISATION
    tickets,
    ticketId,
    ticketSector,
    ticketPrice,
    ticketFan,
    ticketGame := {},{},{},{},{},{}
OPERATIONS
    newTicket <-- createTicket(sector, price, fan, game) =
    PRE
        sector : SECTOR &
        price : NATURAL1 &
        price >= minPrice(sector) & price <= maxPrice(sector) &
        fan : fans &
        game : games
    THEN
        ANY newT
        WHERE newT : TICKET - tickets
        THEN
            tickets := tickets \/ {newT} ||
            ANY
                newTId
            WHERE
                newTId : NATURAL1 & newTId /: ran(ticketId)
            THEN
                ticketId(newT) := newTId
            END ||
            ticketSector(newT):=sector ||
            ticketPrice(newT):=price ||
            ticketFan(newT):=fan ||
            ticketGame(newT):=game ||
            newTicket := newT ||
            increaseGameAttendance(game)
        END
   END;
   
   returnTicketId <-- getTicketId(ticket)=
   PRE
       ticket : tickets
   THEN
       returnTicketId := ticketId(ticket)
   END;
   returnTicketSector <-- getTicketSector(ticket)=
   PRE
       ticket : tickets
   THEN
       returnTicketSector := ticketSector(ticket)
   END;
   returnTicketPrice <-- getTicketPrice(ticket)=
   PRE
       ticket : tickets
   THEN
       returnTicketPrice := ticketPrice(ticket)
   END;
   returnTicketFan <-- getTicketFan(ticket)=
   PRE
       ticket : tickets
   THEN
       returnTicketFan := ticketFan(ticket)
   END;
   returnTicketGame <-- getTicketGame(ticket)=
   PRE
       ticket : tickets
   THEN
       returnTicketGame := ticketGame(ticket)
   END;
   
   setTicketSector(ticket,sector) =
   PRE
       ticket : tickets &
       sector : SECTOR
   THEN
       ticketSector(ticket) := sector
   END;
   setTicketPrice(ticket,price) =
   PRE
       ticket : tickets &
       price : NATURAL1 &
       price >= minPrice(ticketSector(ticket)) & price <= maxPrice(ticketSector(ticket))
   THEN
       ticketPrice(ticket) := price
   END;
   setTicketFan(ticket,fan) =
   PRE
       ticket : tickets &
       fan : fans
   THEN
       ticketFan(ticket) := fan
   END;
   setTicketGame(ticket,game) =
   PRE
       ticket : tickets &
       game : games
   THEN
       ticketGame(ticket) := game
   END;
   
   deleteTicket(ticket) =
   PRE
       ticket : tickets
   THEN
       tickets := tickets - { ticket } ||
       ticketId := { ticket } <<| ticketId ||
       ticketSector := { ticket } <<| ticketSector ||
       ticketPrice := { ticket } <<| ticketPrice ||
       ticketFan := { ticket } <<| ticketFan ||
       ticketGame := { ticket } <<| ticketGame
   END;
   
   deleteAllTicketsForAGame(game) =
   PRE
       game : games
   THEN
       tickets := tickets - ticketGame ~ [{game}] ||
       ticketId := ticketGame ~ [{game}] <<| ticketId ||
       ticketSector := ticketGame ~ [{game}] <<| ticketSector ||
       ticketPrice := ticketGame ~ [{game}] <<| ticketPrice ||
       ticketFan := ticketGame ~ [{game}] <<| ticketFan ||
       ticketGame := ticketGame |>> {game}
   END
END
