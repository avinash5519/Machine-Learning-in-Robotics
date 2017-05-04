function [ Policy ] = WalkQLearning( state )

%No of iterations to update Q
T=100 ;

%initialise Q values
Q=zeros(16,4);


alpha=0.1 ;
gamma=0.9 ;

for k=1:T
  
    %use epsilon greedy policy to generate action 
    action=epsilonGreedyPolicy(Q,state) ;
    Policy(state)=action ;
    
    %find new state and reward for this state and action
    [new_state, reward]=SimulateRobot(state,action)

    %update Q
    
    %find best action fr new state
    maxQNewState=Q(new_state,1);
    for act=2:4
        %which action is best in new_state
        if(maxQNewState < Q(new_state,act))
            maxQNewState=Q(new_state,act);           
        end    
    end 
        
    %update Q values
    Q(state,action)= Q(state,action)+alpha*(reward+gamma*(maxQNewState-Q(state,action)));
    
    %Change state
    state=new_state ;
end

end 