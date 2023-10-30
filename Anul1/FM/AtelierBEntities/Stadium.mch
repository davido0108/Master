/* Stadium
 * Author: Tudor
 * Creation date: 1/18/2023
 */
MACHINE
    Stadium
SEES
    String
SETS
    STADIUM
CONCRETE_CONSTANTS
    maxCapacity
PROPERTIES
    maxCapacity = 100000
VARIABLES
    stadiums,
    stadiumName,
    stadiumCapacity
INVARIANT
    stadiums <: STADIUM &
    stadiumName : stadiums --> STR &
    stadiumCapacity : stadiums >-> NATURAL1 &
    ! st . (st :stadiums => stadiumCapacity(st) <= maxCapacity)
INITIALISATION
    stadiums,
    stadiumName,
    stadiumCapacity := {}, {}, {}
OPERATIONS
    newStadium <-- createStadium(name, capacity) =
    PRE
        name : STR &
        name /: ran(stadiumName) &
        capacity : NATURAL1 &
        capacity <= maxCapacity
    THEN
        ANY newS
        WHERE
            newS : STADIUM - stadiums
        THEN
            stadiums := stadiums \/ {newS} ||
            stadiumName(newS) := name ||
            stadiumCapacity(newS) := capacity ||
            newStadium := newS
        END
    END;
    
    returnStadiumName <-- getStadiumName(stadium) =
    PRE
        stadium : stadiums
    THEN
        returnStadiumName := stadiumName(stadium)
    END;
    returnStadiumCapacity <-- getStadiumCapacity(stadium) =
    PRE
        stadium : stadiums
    THEN
        returnStadiumCapacity := stadiumCapacity(stadium)
    END;
    
    setStadiumName(stadium, name) =
    PRE
        stadium : stadiums &
        name : STR &
        name /: ran(stadiumName)
    THEN
        stadiumName(stadium) := name
    END;
    setStadiumCapacity(stadium, capacity) =
    PRE
        stadium : stadiums &
        capacity : NATURAL1 &
        capacity <= maxCapacity
    THEN
        stadiumCapacity(stadium) := capacity
    END;
    
    deleteStadium(stadium) =
    PRE
        stadium : stadiums
    THEN
        stadiums := stadiums - {stadium} ||
        stadiumName := {stadium} <<| stadiumName ||
        stadiumCapacity := {stadium} <<| stadiumCapacity
    END
        
END
