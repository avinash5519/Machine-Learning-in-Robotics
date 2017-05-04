function [ class ] = classifySequence(A,B,pi,T,N,observation_sequence)
    %Calculate likelihood
    logLikelihood=calculateLikelihood(A,B,pi,T,N,observation_sequence);
    %Convert to log-likelihood
    
   
    
end 