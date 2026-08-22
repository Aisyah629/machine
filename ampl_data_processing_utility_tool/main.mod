/*
 * AMPL Data Processing Utility Model
 * This model demonstrates data aggregation and transformation.
 */

set ITEMS;
set CATEGORIES;

param demand {ITEMS};
param price {ITEMS};
param category {ITEMS} default 'Uncategorized';

/* Aggregated demand per category */
param agg_demand {CATEGORIES} :=
    sum {i in ITEMS: category[i] = C} demand[i], C in CATEGORIES;

/* Derived parameter: total revenue estimate */
param total_revenue :=
    sum {i in ITEMS} demand[i] * price[i];

/* Decision variables for processing volume (simulating a transformation process)
   In a real scenario, this might represent production quantities or allocation.
*/
var Produce {ITEMS} >= 0;

/* Objective: Minimize variance from demand (fitting data) */
minimize Total_Variance:
    sum {i in ITEMS} (Produce[i] - demand[i])^2;

/* Constraints: Ensure production is non-negative (already in var def)
   and maybe bounded by some capacity if needed. */
subject to NonNeg: Produce[i] >= 0 for all i in ITEMS;

/* Display results */
printf "Category Demand Summary:\n";
for {C in CATEGORIES}
    printf "  %s: %d\n" C agg_demand[C];
printf "Total Estimated Revenue: %d\n\n" total_revenue;

printf "Processing Results (Produce vs Demand):\n";
for {i in ITEMS}
    printf "  Item %s: Demand=%d, Produce=%d\n" i demand[i] Produce[i];
