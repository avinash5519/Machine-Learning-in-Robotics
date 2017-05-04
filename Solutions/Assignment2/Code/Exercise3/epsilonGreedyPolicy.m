function [ action ] = epsilonGreedyPolicy( Q,state )

%with 0.3 probabilty it will chose random actions
epsilon=0.3 ;

%pure greedy
%epsilon=0;


temp=rand ;
%rand will give a number between 0 and 1 with uniform distribution. 
% Refer : https://junedmunshi.wordpress.com/2012/03/30/how-to-implement-epsilon-greedy-strategy-policy/

if(temp<epsilon)
   action= selectRandomAction();
else
   action= selectMaxAction(Q,state);
end 

end

function [action]=selectRandomAction()
    %Random action from 1 to 4
    action=ceil(rand(1,1)*4) ;
end 

function [action]=selectMaxAction(Q,state)
    maxQ=Q(state,1);
    action=1 ;
    for act=2:4
        if(maxQ < Q(state,act))
            maxQ=Q(state,act);
            action=act ;
        end 
    end 

end 

