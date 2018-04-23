# brigade git sidecar

On version 0.12 Brigade changed the way it gets the source code. This change made a big improvement of how the source code was fetched on each step.

Previously the script would take a revision ID, clone the repo and set on that ID. The problem here is that on each step the repository was cloned.

On >=0.12 the sidecar takes a ref and a commit ID and only get the required revision. The problem here is that on each call the sidecar needs the red and the commit ID, this is more complex and the callers need extra information.

This sidecar has the logic from the <0.12 sidecar (adapted to the new variables).

## Why

We made the decision of not optimizing the source code retrieval and simplify the calls to Brigade only using the commit ID without the need of infering the branch or ref  to pass the commit ref also. At least for now).

The main problem is when triggering pipeline runs outside the github events (github gateway) where you only have the commit id. For example to trigger a deployment pipeline where you only have the commit version to deploy and making the one triggering the pipeline responsible of infering the commit ref.

Until we see performance bottlenecks cloning all the repo we will stick with this simpler approach.