% This file is part of the XXX distribution (https://github.com/ggargioni/machinelearning).
% Copyright (c) 2018 Gustavo Gargioni.
% 
% This program is free software: you can redistribute it and/or modify  
% it under the terms of the GNU General Public License as published by  
% the Free Software Foundation, version 3.
%
% This program is distributed in the hope that it will be useful, but 
% WITHOUT ANY WARRANTY; without even the implied warranty of 
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU 
% General Public License for more details.
%
% You should have received a copy of the GNU General Public License 
% along with this program. If not, see <http://www.gnu.org/licenses/>.

% GRIDWORLD FROM EXAMPLE 3.8 FROM Reinforcement Learning: An Introduction 
%    (Adaptive Computation and Machine Learning) 1st Edition Edition
% by Richard S. Sutton  (Author), Andrew G. Barto (Author), 
%    Francis Bach (Editor)
% ISBN-13: 978-0262193986
% ISBN-10: 9780262193986

% This code was created by myself to understand better teh concepts of the
% book and are not official versions from the book nor is to be assumed
% this code is the correct implementation. Still it manages to reproduce 
% the expected results from the book.
% built by Gustavo Gargioni, ggargioni@gmail.com in 2018.

clear all;close all;clc;

S=zeros(5);
OutOfBounds=[0 6];
A={[-1 0],[1 0],[0 1],[0 -1]};
Api={0.25,0.25,0.25,0.25};
Value=zeros(5);

% STATE SPACE SETUP
disp("STATE SPACE");
disp(S);
sum(sum(S));

SV=[];
Err=[];
Gamma=.9;
nT=5;
TOL=1e-5;

for k=1:nT
    
    V=Value;
    for i=1:5
        for j=1:5
         
            %% Action Sum Iteration
            ASum=0;
            %When in this states the only action (100%) is to goo
            if i==1 && j==2
                Ra=10;
                SNextValue=V(5,2);
                ASum=(Ra+Gamma*SNextValue);

            elseif i==1 && j==4
                Ra=5;
                SNextValue=V(3,4);
                ASum=(Ra+Gamma*SNextValue);

            else
                %when all other states...
                for a=1:length(A)
                    MOVE=double(A{a});
                    SNextI=i+MOVE(1);
                    SNextJ=j+MOVE(2);

                    if ismember(SNextI, OutOfBounds) || ismember(SNextJ, OutOfBounds)
                        Ra=-1;
                        SNextValue=V(i,j);
                    else
                        Ra=0;
                        SNextValue=V(SNextI,SNextJ);
                    end
                    AiterValue=double(Api{a})*(Ra+Gamma*SNextValue);
                    ASum=ASum+AiterValue;

                end
            end
                

            %% Value Sum
            R=V(i,j); %possibily needed for the future
            Value(i,j)=ASum;
            
        end
    end
    
    SV(k)=sum(sum(Value));
    Err(k)=norm(V-Value)/norm(Value);
    if Err(k)<TOL
        break;
    end
    
end
iter=k;
figure;
semilogy(1:iter,Err)
grid
hold off

figure;
plot(1:iter,SV)
grid
k
V








