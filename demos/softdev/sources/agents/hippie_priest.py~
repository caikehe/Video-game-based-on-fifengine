# -*- coding: utf-8 -*-

# ####################################################################
#  Copyright (C) 2005-2013 by the FIFE team
#  http://www.fifengine.net
#  This file is part of FIFE.
#
#  FIFE is free software; you can redistribute it and/or
#  modify it under the terms of the GNU Lesser General Public
#  License as published by the Free Software Foundation; either
#  version 2.1 of the License, or (at your option) any later version.
#
#  This library is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#  Lesser General Public License for more details.
#
#  You should have received a copy of the GNU Lesser General Public
#  License along with this library; if not, write to the
#  Free Software Foundation, Inc.,
#  51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
# ####################################################################

import random
from fife import fife
from agent import Agent
from hero import Hero
from girl import Girl
from fife.extensions.fife_settings import Setting

#TDS = Setting(app_name="rio_de_hola")

_STATE_RAND, _STATE_WALK, _STATE_READ, _STATE_FALL, _STATE_ATTACK= xrange(5)

class Hippie_priest(Agent):
	def __init__(self, settings, model, agentName, layer, uniqInMap=True):
                self.state = _STATE_RAND
		super(Hippie_priest, self).__init__(settings, model, agentName, layer, uniqInMap)
                self.hero = self.layer.getInstance('PC')
                self.girl = self.layer.getInstance('NPC:girl')

	def onInstanceActionFinished(self, instance, action):
		self.start()            

	def onInstanceActionCancelled(self, instance, action):
		pass
      
	def start(self):
            self.state = _STATE_RAND
            #get the position of the girl 
            self.girlLoc = self.girl.getLocation()
            gl = fife.Location(self.girlLoc).getExactLayerCoordinates()
            #get the position of the hippie_priest
            self.facingLoc = self.agent.getLocation()
            bl = self.facingLoc.getLayerCoordinates()
            bl.x += random.randint(-10, 10)
	    bl.y += random.randint(-10, 10) 
            self.facingLoc.setLayerCoordinates(bl) 
            self.walk(self.facingLoc)

            threshold = 100
            dist1 = (gl.x-bl.x)*(gl.x-bl.x)+(gl.y-bl.y)*(gl.y-bl.y)
            print dist1
            if (dist1 < threshold):
                self.fall()
                #self.read()
                
        def walk(self,location):
            self.state = _STATE_WALK
            self.agent.move('walk', location, 2 * self.settings.get("rio", "TestAgentSpeed"))
 
        def read(self):
            self.state = _STATE_READ
            self.agent.actRepeat('read')

        def fall(self):
            self.state = _STATE_FALL
            self.agent.actOnce('fall')

        def attack(self, target):
            self.state = _STATE_ATTACK
            self.agent.actOnce('attack', target)





















