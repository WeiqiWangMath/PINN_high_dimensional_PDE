function full_grid = generate_full_grid_2D_rand2D(N) % generate random point in rectangle i.i.d.
full_grid_random_x = rand(N*N,1); % 1D grid
full_grid_random_y = rand(N*N,1);
full_grid = [full_grid_random_x,full_grid_random_y];
end

