// Common definitions for the data block
// -- Constants --
int<lower=0> ns_ipd; // number of IPD studies
int<lower=0> ns_agd_arm; // number of AgD (arm-based) studies
int<lower=0> ns_agd_contrast; // number of AgD (contrast-based) studies

int<lower=0> ni_ipd; // total number of IPD individuals
int<lower=0> ni_agd_arm; // total number of AgD (arm-based) data points
int<lower=0> ni_agd_contrast; // total number of AgD (contrast-based) data points

// Treatment IDs
int<lower=1> ipd_trt[ni_ipd];
int<lower=1> agd_arm_trt[ni_agd_arm];
int<lower=1> agd_contrast_trt[ni_agd_contrast];
int<lower=1> agd_contrast_trt_b[ni_agd_contrast];

// Study IDs
int<lower=1> ipd_study[ni_ipd];
int<lower=1> agd_arm_study[ni_agd_arm];
int<lower=1> agd_contrast_study[ni_agd_contrast];

int<lower=1> nt; // number of treatments
int<lower=0> nX; // number of columns of design matrix
int<lower=1> nint; // number of samples for numerical integration
int<lower=1> int_thin; // thinning factor for saved integration points

int<lower=0, upper=1> QR; // use QR decomposition (yes = 1)

// -- AgD (contrast-based) outcomes
real agd_contrast_y[ni_agd_contrast];
real<lower=0> agd_contrast_se[ni_agd_contrast];

// -- Treatment and study indicators --

// -- Design matrix or thin QR decomposition --
matrix[ni_ipd + nint * ni_agd_arm + nint*ni_agd_contrast, QR ? 0 : nX] X;
matrix[ni_ipd + nint * ni_agd_arm + nint*ni_agd_contrast, QR ? nX : 0] Q;
matrix[QR ? nX : 0, QR ? nX : 0] R_inv;

// -- Random effects --
int<lower=1> ipd_arm[ni_ipd]; // Arm indicator for IPD (i.e. picking element of which_RE)
int<lower=0> which_RE[max(ipd_arm) + ni_agd_arm + ni_agd_contrast]; // ID of RE delta for each arm (0 for no RE delta)
corr_matrix[max(ipd_arm) + ni_agd_arm + ni_agd_contrast] RE_cor; // RE correlation matrix

// -- Priors --
int<lower=1,upper=3> prior_intercept_type;
real prior_intercept_location;
real<lower=0> prior_intercept_scale;
real<lower=0> prior_intercept_df;

int<lower=1,upper=3> prior_trt_type;
real prior_trt_location;
real<lower=0> prior_trt_scale;
real<lower=0> prior_trt_df;

int<lower=1,upper=4> prior_het_type;
real<lower=0> prior_het_location;
real<lower=0> prior_het_scale;
real<lower=0> prior_het_df;

int<lower=1,upper=3> prior_reg_type;
real prior_reg_location;
real<lower=0> prior_reg_scale;
real<lower=0> prior_reg_df;