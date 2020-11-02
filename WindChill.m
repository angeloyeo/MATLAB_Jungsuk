function Twc = WindChill(TA, V)

C1 = 35.74;
C2 = 0.6215;
C3 = -35.75;
C4 = 0.4275;

Twc = C1 + C2 * TA + C3 * V^0.16 + C4 * TA * V^0.16;

Twc = round(Twc);
