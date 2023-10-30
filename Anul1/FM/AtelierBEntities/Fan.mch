/* Fan
 * Author: Tudor
 * Creation date: 1/18/2023
 */
MACHINE
    Fan
SEES
    String
SETS
    FAN
VARIABLES
    fans,
    fanId,
    fanName,
    fanEmail
INVARIANT
    fans <: FAN &
    fanId : fans>->NATURAL1 &
    fanName : fans -->STR &
    fanEmail: fans --> STR
INITIALISATION
    fans,
    fanId,
    fanName,
    fanEmail := {}, {}, {}, {}
OPERATIONS
    newFan <-- createFan(name, email) =
    PRE
        name : STR &
        email : STR
    THEN
        ANY newF
        WHERE 
            newF : FAN - fans
        THEN
            fans := fans \/ {newF} ||
            ANY newFId 
            WHERE newFId: NATURAL1 & newFId /: ran(fanId)
            THEN fanId(newF) := newFId
            END ||
            fanName(newF):= name ||
            fanEmail(newF):= email ||
            newFan := newF
        END
    END;
    
    returnFanId <-- getFanId(fan) =
    PRE
        fan : fans
    THEN
        returnFanId := fanId(fan)
    END;
    
    returnFanName <-- getFanName(fan) =
    PRE
        fan : fans
    THEN
        returnFanName := fanName(fan)
    END;
    
    returnFanEmail <-- getFanEmail(fan) =
    PRE
        fan: fans
    THEN
        returnFanEmail := fanEmail(fan)
    END;
    
    
    setFanName(fan,name) =
    PRE
        fan : fans &
        name : STR
    THEN
        fanName(fan) := name
    END;
    
    setFanEmail(fan,email)=
    PRE
        fan : fans &
        email : STR
    THEN
        fanEmail(fan) := email
    END;
        
    
    deleteFan(fan) = 
    PRE
        fan : fans
    THEN
        fans := fans - {fan} ||
        fanId := {fan} <<| fanId ||
        fanName := {fan} <<| fanName ||
        fanEmail := {fan} <<| fanEmail
    END
    
END
