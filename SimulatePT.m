function P = SimulatePT(T1AMP3, T1AMP2, T1AMP1, T1OAP3, T1OAP2, T1OAP1, T2AMP3, T2AMP2, T2AMP1, T2OAP3, T2OAP2, T2OAP1, N)

    T1AVG3 = (T2OAP3+T1AMP3)/(2);
    T1AVG2 = (T2OAP2+T1AMP2)/(2);
    T1AVG1 = (T2OAP1+T1AMP1)/(2);
    T2AVG3 = (T1OAP3+T2AMP3)/(2);
    T2AVG2 = (T1OAP2+T2AMP2)/(2);
    T2AVG1 = (T1OAP1+T2AMP1)/(2);
    
    function D = TwoSimulationPT(P3, P2, P1, P33, P22, P11, N)

            %P3, P2, and P1 are the mean number of 3P made (could also use attempted
            %and add another variable for percentage but this is the beginning simple model)
            %N is the number of simulations
        
            D1 = poissrnd(P3,N,1);
            B1 = poissrnd(P2,N,1);
            C1 = poissrnd(P1,N,1);
        
            %Takes samples from randomly generated poisson distributions with means P3,
            %P2, and P1 respectively
        
            S1 = D1 + B1 + C1;
        
            %Multiplies the randomly generated P3, P2, and P1 numbers obtained with
            %each of their points and adds them up

            A2 = poissrnd(P33,N,1);
            B2 = poissrnd(P22,N,1);
            C2 = poissrnd(P11,N,1);

            S2 = A2 + B2 + C2;

            D = S1 - S2;

            %disp(S1)
            %disp(S2)
            %disp(D)
            
    end
    
    D = TwoSimulationPT(T1AVG3, T1AVG2, T1AVG1, T2AVG3, T2AVG2, T2AVG1, N);
    
    P1 = 0;
    OT = 0;
    for i = 1:N
        while D(i) == 0
            % Call TwoSimulation recursively with the same arguments
            D(i) = TwoSimulationPT(T1AVG3, T1AVG2, T1AVG1, T2AVG3, T2AVG2, T2AVG1, 1);
        end
        if any(D(i) > 0)
            P1 = P1 + 1;
        end
        if any(D(i) == 0)
            OT = OT + 1;
       end
    end

    
    

    %P1P = (1 - (P1/N) - (OT/N)) * 100;
    %OTP = (OT/N) * 100
    %disp("Team 1 will win " + P1P + "% of the time and go to OT " + OTP + "% of the time.")
    %disp("*Simulated using Average")

    P = (P1/N);

    end
