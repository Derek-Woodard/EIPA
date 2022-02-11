%% Harmonic Wave Equation in 2D FD and Modes
% Familiarize yourself with finite difference modeling of the harmonic wave
% equation in 2D and its formulation as a matrix equation and the solution
% for the modes.

clear all
close all

set(0,'DefaultFigureWindowStyle','docked');
%%
% 

% 

k = 1.38064852e-23;
q = 1.60217662e-19;
hb = 1.054571596e-34;             % Dirac constant
m_0 = 9.10938215e-31;             % electron mass
del = 1e-9;

% Set initial sizing of the matrix
nx = 50;
ny = 50;

% Create a sparse matrix of size nx x ny
G = sparse(nx, ny);

% Set diagonal values of G to be 1
% everything else is 0
for i = 1:nx
    G(i,i) = 1;
end


for i = 1:nx
    for j = 1:ny
        % visit every node - calculate for that node what n,nx,nxp,nyp,nym
        % are and assign them into the G matrix
        % put an equation into the G matrix - use if statements for
        % boundaries
        n = j+(i-1)*ny;
        
        if i == 1
            G(n,n) = 1;
        elseif j == 1
            G(n,n) = 1;
        elseif i == nx
            G(n,n) = 1;
        elseif j == ny
            G(n,n) = 1;
        else
            nxm = j+(i-2)*ny;
            nxp = j+(i)*ny;
            nym = (j-1)+(i-1)*ny;
            nyp = (j+1)+(i-1)*ny;
           
            if i < 20 && i > 10 && j < 20 && j > 10
                G(n,n) = -2;
            else
                G(n,n) = -4;
            end
            G(n,nxm) = 1;
            G(n,nxp) = 1;
            G(n,nym) = 1;
            G(n,nyp) = 1;
        end
    end
end

figure(1);
spy(G);

[E,D] = eigs(G,9,'SM');


% Plot the eigenvalues (diagonal of D)
figure(2);
Dplot = D;
Dplot(Dplot==0)=nan;
plot(Dplot, '.');

M1 = zeros(nx,ny);
M2 = zeros(nx,ny);
M3 = zeros(nx,ny);
M4 = zeros(nx,ny);
M5 = zeros(nx,ny);
M6 = zeros(nx,ny);
M7 = zeros(nx,ny);
M8 = zeros(nx,ny);
M9 = zeros(nx,ny);

for k = 1:9
    for i = 1:nx
        for j = 1:ny
            n = j+(i-1)*ny;
            if k == 1
                M1(i,j) = E(n,k);
            elseif k == 2
                M2(i,j) = E(n,k);
            elseif k == 3
                M3(i,j) = E(n,k);
            elseif k == 4
                M4(i,j) = E(n,k);
            elseif k == 5
                M5(i,j) = E(n,k);
            elseif k == 6
                M6(i,j) = E(n,k);
            elseif k == 7
                M7(i,j) = E(n,k);
            elseif k == 8
                M8(i,j) = E(n,k);
            elseif k == 9
                M9(i,j) = E(n,k);
            end
        end
    end
end

figure(3);
subplot(3,3,1)
surf(M1);
subplot(3,3,2)
surf(M2);
subplot(3,3,3)
surf(M3);
subplot(3,3,4)
surf(M4);
subplot(3,3,5)
surf(M5);
subplot(3,3,6)
surf(M6);
subplot(3,3,7)
surf(M7);
subplot(3,3,8)
surf(M8);
subplot(3,3,9)
surf(M9);
