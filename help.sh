
docker run -it           \
   -p 8888:8888          \
   -v $(pwd):/usr/data   \
   -w /usr/data          \
   ipython/scipystack    \
   ipython notebook --ip=0.0.0.0 --no-browser


https://odewahn.github.io/docker-jumpstart/ipython-notebook.html