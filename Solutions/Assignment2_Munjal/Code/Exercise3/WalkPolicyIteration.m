function [ policy ] = WalkPolicyIteration( initial_state )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


No_Of_States=16 ;
No_Of_Actions=4 ;

State_Transition_Matrix=[2 4 5 13; 1 3 6 14; 4 2 7 15; 3 1 8 16; 6 8 1 9;5 7 2 10; 8 6 3 11; 7 5 4 12; 10 12 13 5; 9 11 14 6; 12 10 15 7;
11 9 16 8; 14 16 9 1; 13 15 10 2; 16 14 11 3;15 13 12 4;];


Reward_Matrix=prepareRewardMatrix(No_Of_States,No_Of_Actions);
 

policy=ceil(rand(16,1)*4);
Prev_Value=zeros(16,1);
Value=zeros(16,1);

%discount factor
gamma=0.1 ;
%Repeat till convergence


%Calculate value for policy


%store sum of values ..compare these sum to find if there is change in values
current=0 ;
pre=1 ;
  

no_of_steps=0 ;

while(abs(current-pre) ~= 0)  

    no_of_steps=no_of_steps+1 ;
    %matrix of coficients
    A=zeros(16,16) ;
    %matrix of right hand side
    B=[];   
    pre=sum(Value) ;
    
for state=1:16
    action_acc_to_policy=policy(state);
    next_state=State_Transition_Matrix(state,action_acc_to_policy);
    
    %Write the following equations in matrix form AX=B
    % Value(state)= Reward_Matrix(state,action_acc_to_policy)+gamma*Value(next_state);
    if(state == next_state)
        A(state,state)=1-gamma ;
    else
        A(state,state)=1;
        A(state,next_state)=-gamma ;
    end 
    B=[B; Reward_Matrix(state,action_acc_to_policy);];
end 

%solve the 16 equations to get 16 values of states
X=inv(A)*B ;

Value=X ;

current=sum(Value);

%improve the policy
    policyUpdated=false ;
 
    for state=1:16
        maxValue=Value(state) ;
        
        for action=1:4
            next_state=State_Transition_Matrix(state,action);            
            New_Value=Reward_Matrix(state,action)+gamma*Value(next_state);
            if(New_Value > maxValue)
                policy(state)=action ;
                maxValue=New_Value ;
                policyUpdated=true ;
            end 
        end 
        
    end
    
    if policyUpdated==false 
        break; 
    end 
    
   
    
    
end
 
no_of_steps
end 



function[Reward_Matrix]=prepareRewardMatrix(No_Of_States,No_Of_Actions)

Reward_Matrix=[7 -7  7 -7;
             -7 7 -7 -7;
             7 -7 -7 -7;
             -7 -7 7 -7;
             -7 -7 -7 7;
             7 -7 7 -7;
             7 -7  7 -7;
             -7 7 -7 -7;
             -7 -7 7 -7;
             7 -7 7  -7;
             7  7  7  7; 
             -7 7 -7 7;
             7 -7 -7 -7; 
             -7 -7 -7 7;
             -7 7 -7 7;
             -7 7 -7 7];


    
end 


