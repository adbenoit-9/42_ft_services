# :heart: Ft_services :heart:
Here, we are going to compare cluster to a little cutie house that we'll try to build. :cherry_blossom:

OF COURSE WE WILL SUCCEED, WE ARE NOT STUPID GOATS !!!
## Kube construction
![Example](img/start.png)

obvious command: 
`$ minikube start [option]`

![Example](img/kube.png)

## Add a door
(aka. Load Balancer)
### Goal
Connect the inside of the house to the external world.
### Needed (aka. ConfigMap)
- protocole : according to the utility of a door (= connecting the differents rooms of a house to the outside), we'll use the protocole layer2 to create the door. If you don't understanding why :
![Example](img/intermarche.png)
- tools : OMG but how can i know where i can find the tools needed ?? :sob: CALM DOWN !!! :lotus_position_woman: I'm not sure yet but for the momemt you just need to find in the beautyful internetmarche how to install metallb and check the place (aka. namespace) in the config file 
- choose the position & the size of the door (aka. adresses range)

```
$ kubectl apply -f metallb.yaml
$ kubectl apply -f configmap.yaml
```
![Example](img/door.png)

## Arrange the rooms
(aka. nodes)

Every room has it's own function (aka. service) => kitchen, living room, etc ... 
