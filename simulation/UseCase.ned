//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
// 

package simulation;

import inet.node.ethernet.Eth10G;
//import inet.node.inet.StandardHost;
//import inet.node.ethernet.EthernetSwitch;
import inet.node.tsn.TsnDevice;
import inet.node.tsn.TsnSwitch;

//import inet.linklayer.configurator.MacForwardingTableConfigurator;

import simu5g.nodes.NR.NRUe;
import simu5g.nodes.NR.gNodeB;
import simu5g.nodes.Upf;

import src.FiveGNetworkBase;
import src.NRUeEth;
import src.gNBEth;
import src.UpfEth;
import src.TT;

network UseCase extends FiveGNetworkBase
{
    parameters:
        **.ipv4.arp.typename = "GlobalArp";
        @display("bgb=1569.2401,739.2138");
    submodules:
        upf: UpfEth {
            @display("p=1112.8975,426.67624");
        }
        gNB: gNBEth {
            @display("p=985.0912,426.67624");
        }
        ue: NRUeEth {
            @display("p=827.7912,426.67624");
        }
        DSTT: TT;
        NSTT: TT;
        TsnDS: TsnDevice {
            @display("p=471.89996,599.70624");
        }
        switch5GC: TsnSwitch {
            @display("p=1344.9149,521.0562");
        }
        switchTSN: TsnSwitch {
            @display("p=607.5712,538.75244");
        }
        TsnNS: TsnDevice {
            @display("p=1510.08,611.5037");
        }
    connections:
        TsnNS.ethg++ <--> Eth10G <--> switch5GC.ethg++;
        NSTT.ethg++ <--> Eth10G <--> upf.filterGate;
        switch5GC.ethg++ <--> Eth10G <--> NSTT.ethg++;
        upf.ethg++ <--> Eth10G <--> gNB.ethg;
        ue.ethg++ <--> Eth10G <--> DSTT.ethg++;
        DSTT.ethg++ <--> Eth10G <--> switchTSN.ethg++;
        switchTSN.ethg++ <--> Eth10G <--> TsnDS.ethg++;

}