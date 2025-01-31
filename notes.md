<script type="text/javascript" async
  src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/MathJax.js?config=TeX-MML-AM_CHTML">
</script>


# 1. Bootstrap

Bootstrap methods are a class of methods that estimate the distribution of a population by resampling.

they are often used when the distribution of the population is unkown and the sample is the only given information. 

__Bootstraping constists of 4 step:__

https://www.youtube.com/watch?v=Xz0x-8-cgaQ&t=400s
1. Make a bootstraped dataset
2. calculate something (for example the mean/mean/standard deviation)
3. keep track of that calculation
4. repeat steps 1-3...

### $E(X^{* }) \text{ and } V(X^{*})$ in bootstrap
In the "boostrap world" we have to estimate the expected value and the variance as the following:

$$E(X^{*}) = \sum_{i}^{n} x_{i} p(x_{i}) = \sum_{i}^{n} x_{i} \cdot \frac{1}{n} = x_{mean} $$

$$V(X^{*})= E[X^{*}- E[X^{*}]]^2 = E[X^{*}- X_{mean}]^2 = \sum_{i} (x_{i} - x_{mean})^2 \cdot p(x_{i})$$
$$= \sum_{i} (x_{i} - x_{mean})^2 \cdot \frac{1}{n}$$

### 1.1 general idea:
Use the sample to estimate the unkown sampling distribution of the data

(1) Generate B-number of samples, sampled uniformly with replacement from
$\{x_{1}, ..., x_{n} \}$.
$$ x^{*b} = x_{1}^{*}, ..., x_{n}^{*}$$
and compute the distribution every time
$$ \theta^{(b)} = \theta(x_{1}^{*}, ..., x_{n}^{*})$$

Use this to calculate the empirical CDF of 
$\theta^{(1)}, ..., \theta^{(B)}$ that will give you the boostrap estimate of $F_{\theta}$.

## 1.2 Bias of estimation
The bias of the estimator calculates how for the exopected value is from the true value of the parameter $\theta$.

__Compute bias:__

$\text{bias} (\theta) = E(\theta^{*}) - \theta$

where $\theta^{*}$ is the exptected value (or mean):
$$E(\theta^{*})= \theta_{mean} = \frac{1}{B} \sum_{b=1}^{B} \theta^{*b}$$

## 1.3 Bias corrected Estimate

$$\theta_{bc}= \theta^{*} - bias(\theta) = \theta^{*} - E(\theta^{*}) + \theta_{true}$$
$$E(\theta_{bc}) = E(\theta^{*}) - E(\theta^{*}) + \theta_{true} = \theta_{true}$$


## 1.4 Variance 
__Compute Variance:__
$$\text{var}(\theta) = \frac{1}{B-1} \sum_{b=1}^{B} \left( \theta^{(b)} - \theta^{*} \right)^2$$


## 1.5 standard normal boostrap - CI
This simple and easy to compute but it ignores varibility in standard errors.

- Let $\theta$ be an unknown paramter estimated by: $\theta^{*}(X_{1},X_{2},...X_{n})$
how do we construct a (1-$\alpha$)CL for $\theta$ ?

### Answer:
(1) assume $\theta$ is unbiased and normal and that $$Z= \frac{\theta^{*} - \theta}{se(\theta^{*})} \approx N(0,1)$$

(2) Use boostrap to estimate $$se^{*}(\theta^{*})$$

(3) (1-$\alpha$) CI: $$\theta^{*} \pm z_{\alpha/2} \cdot se(\theta^{*})$$


## 1.6 Bootstrap t-interval

__Pro:__ We are not assuming normality anymore\
__Cons:__ Bootstrap nested in Bootstrap, which can lead to heavy computation. We also have to know a pivot (t). It is not invariant to transformation.

do the following B-times:

1. 
(1.1) generate bootstrap sample $x^{*,b}=x^{*}_{1},...,x_{n}^{*}$ by sampling with replacement from $x_{1},...x_{n}$.

(1.2) Compute $\theta^{*(b)} = \theta^{*}(x^{*}_{1},...,x^{*}_{n})$

(1.3) Compute or estimate the standard error for each b:
$$se^{*}(\theta^{*(b)})$$
a boostrap estimate will in this case sample from $x^{*(b)} \text{ and not } x$.

(1.4) Compute: $$t^{(b)}= \frac{\theta^{*(b)} - \theta}{se^{*}(\theta^{*(b)})}$$

2.

(2.2)
find the sample quantiles
$$t^{*}_{\alpha/2} \text{ and } t^{*}_{1-\alpha/2}$$
from the sample of the replicates: $t_{1}, ...,t_{B}$

(2.3)
compute the standard error:
$$se^{*}(\theta^{*})=\sqrt{\frac{1}{B-1} \cdot \sum_{b=1}^{B} \left( \theta^{*(b)} - \theta \right)^{2} } $$\\


(2.4)
$(1-\alpha)$CI: $$(\theta^{*} - t^{ *}_{1- \alpha /2} \cdot se^{ *}(\theta^{ *}), \theta^{*} - t^{ *}_{\alpha /2} \cdot se^{ *}(\theta^{ *}))$$


## 1.7 Precentile Bootstrap CI

__Pros:__ We don't need a pivot. It is invariant to transformation.

__cons:__ We need B to be large (between 5k and 10k). We also need symmetry, meaning the CDF-function has to be symmetric

Let $P(\theta^{*} \leq u)=H(u;\theta)$

where we estimate $H$ by the bootstrap distribution $H^{*}$, that is the empirical CDF of the bootstrap replicates.
$$\theta^{*}_{1},..., \theta^{*}_{B}$$

which gives us the confidence inteval:
$$CI: \left[H^{*-1}(\alpha/2), H^{*-1}(1-\alpha/2)\right]$$

where $$H^{*}(u) = \frac{1}{B} \cdot \sum_{b=0}^{B} I(\theta^{*b} \leq u)$$

```plaintext
For 1,...b
    Generate x_*1,...x_*n by sampling from x_1,..,x_n
    
    compute theta_b

find quantiles

generate confidence interval
```

## 1.8 Hall's percentile Bootstrap CI
__Pros:__ Here we dont need symmetry

Choose $t_{1},t_{2}$ such that $P(\theta + t_{2} < \theta < \theta + t_{1}) = 1 - \alpha$

$$\implies \theta + t_{1} = \theta_{1-\alpha/2} \quad \theta - t_{2} = \theta_{\alpha/2}$$

$$CI: \left[ 2\theta^{*} - \theta_{1-\alpha/2}, 2\theta^{*} - \theta_{\alpha/2} \right]$$


# Permuatation...

## Exact CI
used when we want to compute the p for a binomial using confidence level $1-\alpha$
It does not rely on large sample distributions, but is based on the exact binomial distribution, making it accurate for even small samples.

the confidence level is always guaranteed to be at least $(1-\alpha)$. it is conservative.

$p_{l}, p_{u}$ are found by computing:
$$\sum_{k=0}^{x} p^{k}_{u}(1-p_{u}^{k})^{n-k} = \frac{\alpha}{2} \rightarrow \quad P(B(n;p_{l}) \leq x )= \frac{\alpha}{2}$$
$$\sum_{k=0}^{x} p^{k}_{l}(1-p_{l}^{k})^{n-k} = \frac{\alpha}{2}  \rightarrow \quad P(B(n;p_{u}) \geq x )= \frac{\alpha}{2}$$$$
where: \
x - number of successes\
n - number of trials\
$p_{u/l}$ - lower and upper bound\
$\alpha$ - significance level

This methods finds $p_{l},p_{u}$ such that the probability of observing x successes or less is $\alpha / 2$ for $p_{u}$.
and the probability of observing x successes or more is $\alpha / 2$ for $p_{l}$

__hypothesis test__ ($H_{0}, p=p_{u}$) \
since $P(B(n;p_{l}) \leq x )= \frac{\alpha}{2} \implies p_{value} \geq \alpha / 2$, so we dont reject the null hypothesis. If we were to pick a p that is bigger the probability would be smaller than $\alpha / 2$. And we would then reject it. This means $p_{u}$ is the last p-value for which we dont reject.


## RR or OR

Let 0 be the control group and 1 the treated group. We can then measure treatment in the following way:

__Risk difference:__ $\quad \Delta = p_{1} - p_{0}$

__Risk ratio (RR):__ $\quad RR = p_{1} / p_{0}, \quad 0 \leq RR \leq \infty$


__Odds ratio (OR):__ $\quad OR = \frac{p_{1} (1-p_{0})}{p_{0} (1-p_{1})}, \quad 0 \leq OR \leq \infty$

- $p_{0} = p_{1} \implies \Delta = 0\quad iff:$ X and Y are independent iff
$$RR=1 \quad or  \quad OR =1$$

- $RR > 1 \quad or \quad OR > 1$ implies that exposure increases the risk of diseas of event of interest.

- $RR \approx OR$ implies that the disease/outcome is rare


## Permutation test
A permutation test involves two or more samples. The `null hypothesis` is that they come from the same distributiion.

__Pros:__ no assumption of normality is needed. Works well in small sample sizes.

### Method
shuffle the data in all possible ways and calculate the test-statistic. It is based on the principle of `proof by contradiction`, meaning it tests wether the observed data would be likely or unlikely assuming that there is no real difference in the group.

__(1) Test statistic:__
Compute an observed test statistic $T_{observed}$ such as the difference in mean for example:
$$T = X_{mean} - Y_{mean}$$

__(2) creating samples:__
Say we have two samples:
$$X_{1},...,X_{n} ∼ i.i.d \quad F_{X}$$
$$Y_{1},...,Y_{m} ∼ i.i.d \quad F_{Y}$$

the null hypothesis is: $X ∼ Y$ they are from the same distribution.

We create a pooled sample $Z$ where all values are interchangeable under $H_{0}$ since they then come from the same ditrbibution:
$$Z = \{X_{1},..,X_{n}, Y_{1},...,Y_{m} \} \quad N=m+n$$

__(3) permutation process & computing `p-value`:__
- a `permutation` is a random shuffling of indices $\{1,...,N\}$.
from the shuffled data the first n-values are assigned as $X^{\pi}$ and the remaining m-values as $Y^{\pi}$
This simulates the null hypothesis by ensuring that any grouping is equally likely.

- the `p-value` is the proportion of permutations where the $T_{\pi}$ is at least as extreme as extreme as $T_{observed}$.

$$\text{p-value} = \frac{\# \{\pi : T_{\pi} \geq T_{oberved}\}}{N!}$$

