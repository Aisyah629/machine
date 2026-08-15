/* 
 * Mathematical Programming Model
 * Optimizes resource allocation and supply chain logistics
 * using standard AMPL syntax.
 */

/* Set of products */
set PRODUCTS;

/* Set of distribution centers */
set DISTRIBUTION_CENTERS;

/* Set of raw materials */
set RAW_MATERIALS;

/* Parameters */
param demand{PRODUCTS};
param capacity{DISTRIBUTION_CENTERS};
param cost{PRODUCTS, DISTRIBUTION_CENTERS};
param raw_mat_cost{RAW_MATERIALS};
param required_mat{PRODUCTS, RAW_MATERIALS};

/* Decision variables */
var Produce{PRODUCTS, DISTRIBUTION_CENTERS} >= 0;
var RawMaterialUsed{RAW_MATERIALS} >= 0;

/* Objective: Minimize total production and transportation cost */
minimize Total_Cost:
    sum {p in PRODUCTS, d in DISTRIBUTION_CENTERS} cost[p, d] * Produce[p, d] +
    sum {r in RAW_MATERIALS} raw_mat_cost[r] * RawMaterialUsed[r];

/* Constraint: Meet demand for each product at each distribution center */
subject to Demand_Constraint {p in PRODUCTS, d in DISTRIBUTION_CENTERS}:
    Produce[p, d] >= demand[p] / cardinality(DISTRIBUTION_CENTERS);

/* Constraint: Respect distribution center capacity */
subject to Capacity_Constraint {d in DISTRIBUTION_CENTERS}:
    sum {p in PRODUCTS} Produce[p, d] <= capacity[d];

/* Constraint: Raw material usage matches product requirements */
subject to RawMaterial_Constraint {r in RAW_MATERIALS}:
    sum {p in PRODUCTS} required_mat[p, r] * sum {d in DISTRIBUTION_CENTERS} Produce[p, d] <= RawMaterialUsed[r];

/* Solve the model */
option solver cplex;
solve;

/* Display the results */
display Produce;
display Total_Cost;
