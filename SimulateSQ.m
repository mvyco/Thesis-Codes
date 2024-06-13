function P = SimulateSQ(T1AMP3, T1AMP2, T1AMP1, T1OAP3, T1OAP2, T1OAP1, T2AMP3, T2AMP2, T2AMP1, T2OAP3, T2OAP2, T2OAP1, N)

    T1SQ3 = (T2OAP3*T1AMP3)^(1/2);
    T1SQ2 = (T2OAP2*T1AMP2)^(1/2);
    T1SQ1 = (T2OAP1*T1AMP1)^(1/2);
    T2SQ3 = (T1OAP3*T2AMP3)^(1/2);
    T2SQ2 = (T1OAP2*T2AMP2)^(1/2);
    T2SQ1 = (T1OAP1*T2AMP1)^(1/2);
    
    %disp("T1AMP3 = " + T1AMP3)
    %disp("T1AMP2 = " + T1AMP2)
    %disp("T1AMP1 = " + T1AMP1)
    %disp("T1OAP3 = " + T1OAP3)
    %disp("T1OAP2 = " + T1OAP2)
    %disp("T1OAP1 = " + T1OAP1)

    %disp("T2AMP3 = " + T2AMP3)
    %disp("T2AMP2 = " + T2AMP2)
    %disp("T2AMP1 = " + T2AMP1)
    %disp("T2OAP3 = " + T2OAP3)
    %disp("T2OAP2 = " + T2OAP2)
    %disp("T2OAP1 = " + T2OAP1)

    %disp("T1AVG3 = " + T1AVG3)
    %disp("T1AVG2 = " + T1AVG2)
    %disp("T1AVG1 = " + T1AVG1)

    %disp("T2AVG3 = " + T2AVG3)
    %disp("T2AVG2 = " + T2AVG2)
    %disp("T2AVG1 = " + T2AVG1)
    
    function D = TwoSimulation(P3, P2, P1, P33, P22, P11, N)

            %P3, P2, and P1 are the mean number of 3P made (could also use attempted
            %and add another variable for percentage but this is the beginning simple model)
            %N is the number of simulations
        
            A1 = poissrnd(P3,N,1);
            B1 = poissrnd(P2,N,1);
            C1 = poissrnd(P1,N,1);
        
            %Takes samples from randomly generated poisson distributions with means P3,
            %P2, and P1 respectively
        
            S1 = A1*3 + B1*2 + C1;
        
            %Multiplies the randomly generated P3, P2, and P1 numbers obtained with
            %each of their points and adds them up

            A2 = poissrnd(P33,N,1);
            B2 = poissrnd(P22,N,1);
            C2 = poissrnd(P11,N,1);

            S2 = A2*3 + B2*2 + C2;

            D = S1 - S2;
            end
    
    D1 = TwoSimulation(T1SQ3, T1SQ2, T1SQ1, T2SQ3, T2SQ2, T2SQ1, N);
    
    P1 = 0;
    OT = 0;
    for i = 1:N
        while D1(i) == 0
            % Call TwoSimulation recursively with the same arguments
            D1(i) = TwoSimulation(T1SQ3, T1SQ2, T1SQ1, T2SQ3, T2SQ2, T2SQ1, 1);
        end
        if any(D1(i) > 0)
            P1 = P1 + 1;
        end
        if any(D1(i) == 0)
            OT = OT + 1;
       end
    end

    %P1P = (1 - (P1/N) - (OT/N)) * 100;
    %OTP = (OT/N) * 100
    %disp("Team 1 will win " + P1P + "% of the time and go to OT " + OTP + "% of the time.")
    %disp("*Simulated using Average")

    P = (P1/N);
    end
