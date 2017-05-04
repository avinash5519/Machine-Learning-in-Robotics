function [ logLikelihood ] = calculateLikelihood( A,B,pi,T,N,observation_sequence)
     
    %Forward algorithm for HMM
    
    alpha=zeros(T,N);

    
    %INITIALISATION
    for i=1:N
        first_observation=observation_sequence(1);
        alpha(1,i)=pi(i)*B(first_observation,i);
    end     

    %INDUCTION
    for t=1:T-1
        for j=1:N
            sum1=0 ;
            for i=1:N
              sum1=sum1+alpha(t,i)*A(i,j);
            end 
            observation_at_t_plus_1 = observation_sequence(t+1);
            alpha(t+1,j)=sum1*B(observation_at_t_plus_1,j);
        end 
    end 

    %TERMINATION
    probability=0 ;
    for k=1:N
        probability=probability+alpha(T,k);
    end 
    logLikelihood=log(probability);
end

