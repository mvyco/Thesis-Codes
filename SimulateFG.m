function P = SimulateFG(T1AMP3, T1AMP2, T1AMP1, T1OAP3, T1OAP2, T1OAP1, T1FG3, T1FG2, T1FG1, T1DFG3, T1DFG2, T1DFG1,  T2AMP3, T2AMP2, T2AMP1, T2OAP3, T2OAP2, T2OAP1, T2FG3, T2FG2, T2FG1, T2DFG3, T2DFG2, T2DFG1, N)

    T1AVG3 = (T2OAP3+T1AMP3)/(2);
    T1AVG2 = (T2OAP2+T1AMP2)/(2);
    T1AVG1 = (T2OAP1+T1AMP1)/(2);
    T2AVG3 = (T1OAP3+T2AMP3)/(2);
    T2AVG2 = (T1OAP2+T2AMP2)/(2);
    T2AVG1 = (T1OAP1+T2AMP1)/(2);

    T1OFG3 = (T1FG3+T2DFG3)/2;
    T1OFG2 = (T1FG2+T2DFG2)/2;
    T1OFG1 = (T1FG1+T2DFG1)/2;

    T2OFG3 = (T1DFG3+T2FG3)/2;
    T2OFG2 = (T1DFG2+T2FG2)/2;
    T2OFG1 = (T1DFG1+T2FG1)/2;
    
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
    
    function D = TwoSimulationS(P3, P2, P1, P33, P22, P11, PC3, PC2, PC1, PC33, PC22, PC11, N)

            %P3, P2, and P1 are the mean number of 3P made (could also use attempted
            %and add another variable for percentage but this is the beginning simple model)
            %N is the number of simulations
        
            A1 = poissrnd(P3,N,1);
            B1 = poissrnd(P2,N,1);
            C1 = poissrnd(P1,N,1);
        
            %Takes samples from randomly generated poisson distributions with means P3,
            %P2, and P1 respectively
        
            S1 = 3*A1*PC3 + 2*B1*PC2 + C1*PC1;
        
            %Multiplies the randomly generated P3, P2, and P1 numbers obtained with
            %each of their points and adds them up

            A2 = poissrnd(P33,N,1);
            B2 = poissrnd(P22,N,1);
            C2 = poissrnd(P11,N,1);

            S2 = 3*A2*PC33 + 2*B2*PC22 + C2*PC11;

            D = S1 - S2;
            
            S1 = sort(S1);
            U = unique(S1);
            idx = 0;
            for i = 1:length(U)
                for id = 1:length(S1)
                        if U(i) == S1(id)
                            idx = idx + 1;
                            else 
                        end
                end
                FREQ(i) = idx;
                id = 1;
                idx = 0;
            end
            plot(U, FREQ)

            disp(mean(S1))
            disp(var(S1))
            %disp(S1)
            %disp(S2)
            %disp(D)

    end
    
    D1 = TwoSimulationS(T1AVG3, T1AVG2, T1AVG1, T2AVG3, T2AVG2, T2AVG1, T1OFG3, T1OFG2, T1OFG1, T2OFG3, T2OFG2, T2OFG1, N);
    
    P1 = 0;
    OT = 0;
    for i = 1:N
        while D1(i) == 0
            % Call TwoSimulation recursively with the same arguments
            D1(i) = TwoSimulationS(T1AVG3, T1AVG2, T1AVG1, T2AVG3, T2AVG2, T2AVG1, T1OFG3, T1OFG2, T1OFG1, T2OFG3, T2OFG2, T2OFG1, 1);
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