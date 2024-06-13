function D = SimulateGraph(T1AMP3, T1AMP2, T1AMP1, T1OAP3, T1OAP2, T1OAP1, T2AMP3, T2AMP2, T2AMP1, T2OAP3, T2OAP2, T2OAP1, N)
    %Interpolates the average made 3's, 2's, and 1's allowed by the opponent of a
    %team and the average made 3's, 2's, and 1's made by said team
    
    %OAP3, OAP2, and OAP1 - Opponent average number of allowed 3's, 2's, and %1's.
    %AMP3, AMP2, and AMP1 - Average number of made 3's, 2's, and %1's.
    
    T1SQ3 = (T2OAP3*T1AMP3)^(1/2);
    T1AVG3 = (T2OAP3+T1AMP3)/(2);
    T1SQ2 = (T2OAP2*T1AMP2)^(1/2);
    T1AVG2 = (T2OAP2+T1AMP2)/(2);
    T1SQ1 = (T2OAP1*T1AMP1)^(1/2);
    T1AVG1 = (T2OAP1+T1AMP1)/(2);

    T2SQ3 = (T1OAP3*T2AMP3)^(1/2);
    T2AVG3 = (T1OAP3+T2AMP3)/(2);
    T2SQ2 = (T1OAP2*T2AMP2)^(1/2);
    T2AVG2 = (T1OAP2+T2AMP2)/(2);
    T2SQ1 = (T1OAP1*T2AMP1)^(1/2);
    T2AVG1 = (T1OAP1+T2AMP1)/(2);

    disp("T1AMP3 = " + T1AMP3)
    disp("T1AMP2 = " + T1AMP2)
    disp("T1AMP1 = " + T1AMP1)
    disp("T1OAP3 = " + T1OAP3)
    disp("T1OAP2 = " + T1OAP2)
    disp("T1OAP1 = " + T1OAP1)

    disp("T2AMP3 = " + T2AMP3)
    disp("T2AMP2 = " + T2AMP2)
    disp("T2AMP1 = " + T2AMP1)
    disp("T2OAP3 = " + T2OAP3)
    disp("T2OAP2 = " + T2OAP2)
    disp("T2OAP1 = " + T2OAP1)

    disp("T1SQ3 = " + T1SQ3)
    disp("T1SQ2 = " + T1SQ2)
    disp("T1SQ1 = " + T1SQ1)
    disp("T1AVG3 = " + T1AVG3)
    disp("T1AVG2 = " + T1AVG2)
    disp("T1AVG1 = " + T1AVG1)

    disp("T2SQ3 = " + T2SQ3)
    disp("T2SQ2 = " + T2SQ2)
    disp("T2SQ1 = " + T2SQ1)
    disp("T2AVG3 = " + T2AVG3)
    disp("T2AVG2 = " + T2AVG2)
    disp("T2AVG1 = " + T2AVG1)
    
        function S = Simulate(P3, P2, P1, N)

            %P3, P2, and P1 are the mean number of 3P made (could also use attempted
            %and add another variable for percentage but this is the beginning simple model)
            %N is the number of simulations
        
            A = poissrnd(P3,N,1);
            B = poissrnd(P2,N,1);
            C = poissrnd(P1,N,1);
        
            %Takes samples from randomly generated poisson distributions with means P3,
            %P2, and P1 respectively
        
            S = A*3 + B*2 + C;
        
            %Multiplies the randomly generated P3, P2, and P1 numbers obtained with
            %each of their points and adds them up

        end

        function [] = PLT(X) 
            X = sort(X);
            U = unique(X);
            idx = 0;
            for i = 1:length(U)
                for id = 1:length(X)
                        if U(i) == X(id)
                            idx = idx + 1;
                            else 
                        end
                end
                FREQ(i) = idx;
                id = 1;
                idx = 0;
            end
            plot(U, FREQ)
        end

    A1 = Simulate(T1AVG3, T1AVG2, T1AVG1, N);
    A2 = Simulate(T2AVG3, T2AVG2, T2AVG1, N);
    D1 = A1 - A2;

    T1A1 = mean(A1, "all");
    T2A2 = mean(A2, "all");
    disp("Team 1 will score an average of " + T1A1)
    disp("Team 2 will score an average of " + T2A2)
    P1 = 0;
    i = 0;
    for i = 1:N
        if any(D1(i) < 0)
            P1 = P1 + 1;
       end
    end
    P1P = (1 - (P1/N)) * 100;
    disp("Team 1 will win " + P1P + "% of the time")
    disp("*Simulated using Average")
    

    S1 = Simulate(T1SQ3, T1SQ2, T1SQ1, N);
    S2 = Simulate(T2SQ3, T2SQ2, T2SQ1, N);
    D2 = S1 - S2;
    T1S1 = mean(S1, "all");
    T2S2 = mean(S2, "all");
    disp("Team 1 will score an average of " + T1S1)
    disp("Team 2 will score an average of " + T2S2)
    P2 = 0;
    i = 0;
    for i = 1:N
        if any(D2(i) < 0)
            P2 = P2 + 1;
       end
    end
    P2P = (1 - (P2/N)) * 100;
    disp("Team 1 will win " + P2P + "% of the time")
    disp("*Simulated using Square Root")
   
    A1 = sort(A1);
            U = unique(A1);
            idx = 0;
            for i = 1:length(U)
                for id = 1:length(A1)
                        if U(i) == A1(id)
                            idx = idx + 1;
                            else 
                        end
                end
                FREQ(i) = idx;
                id = 1;
                idx = 0;
            end
            %disp(U)
     plot(U, FREQ)

end


