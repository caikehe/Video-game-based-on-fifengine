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
from beekeeper import Beekeeper
from fife.extensions.fife_settings import Setting

#TDS = Setting(app_name="rio_de_hola")

_STATE_ATTACK, _STATE_RUNAWAY, _STATE_FLY, _STATE_HIT_BEE = xrange(4)

class Bee(Agent):
	def __init__(self, settings, model, agentName, layer, uniqInMap=True):
		super(Bee, self).__init__(settings, model, agentName, layer, uniqInMap)
		self.state = _STATE_FLY
                self.hero = self.layer.getInstance('PC')
                self.girl = self.layer.getInstance('NPC:girl')
                self.beekeeper = self.layer.getInstance('beekeeper')

	def onInstanceActionFinished(self, instance, action):
		self.start()
                

	def onInstanceActionCancelled(self, instance, action):
		pass
      

	def start(self):
            self.state = _STATE_FLY

            self.facingLoc = self.agent.getLocation()
            
            bl = self.facingLoc.getLayerCoordinates()
	    bl.x += random.randint(-5, 5)
	    bl.y += random.randint(-5, 5) 
            # reset the coordinates of bees
            self.facingLoc.setLayerCoordinates(bl) 
	    self.agent.move('fly', self.facingLoc , 4 * self.settings.get("rio", "TestAgentSpeed"))

            gl, hl = self.getBoyGirlPosi(self.girl, self.hero)
            self.runaway(bl, gl)
            # self.attack(bl, gl, hl)

            target = self.agent.getLocationRef()
            self.hit_bee(target, bl, hl)

        
        # get the coordinates of the boy and girl
        def getBoyGirlPosi(self, name1, name2):
            self.girlLoc = name1.getLocation()
            gl = fife.Location(self.girlLoc).getExactLayerCoordinates()
            self.heroLoc = name2.getLocation()
            hl = self.heroLoc.getLayerCoordinates()     
            return gl,hl


        def runaway(self, bl, gl):
            self.state = _STATE_RUNAWAY
          
            threshold = 100
            dist1 = (gl.x-bl.x)*(gl.x-bl.x)+(gl.y-bl.y)*(gl.y-bl.y)
            if (dist1 < threshold):
                bl.x += 40
                bl.y += 40 
                self.facingLoc.setLayerCoordinates(bl)
                self.agent.move('fly', self.facingLoc, 20 * self.settings.get("rio", "TestAgentSpeed"))

            
        def attack(self, bl, gl, hl):
            self.state = _STATE_ATTACK
            
            threshold = 100
            dist1 = (gl.x-bl.x)*(gl.x-bl.x)+(gl.y-bl.y)*(gl.y-bl.y)
            dist2 = (hl.x-bl.x)*(hl.x-bl.x)+(hl.y-bl.y)*(hl.y-bl.y)
            if (dist1 < threshold or dist2 < threshold):
                self.facingLoc.setLayerCoordinates(bl)
                self.agent.actOnce('attack', self.facingLoc, 20 * self.settings.get("rio", "TestAgentSpeed"))


        def hit_bee(self,target, bl, hl):
            self.state = _STATE_HIT_BEE
            
            dist2 = (hl.x-bl.x)*(hl.x-bl.x)+(hl.y-bl.y)*(hl.y-bl.y)
            threshold = 100
            if (dist2 < threshold):
                self.hero.actOnce('kick', target)
                self.agent.actRepeat('fall')
                # the beekeeper will move to the bees's position and talk with them
                self.facing = self.beekeeper.getLocation()
                self.facing.setLayerCoordinates(bl)
                self.beekeeper.move('walk',self.facing,10 * self.settings.get("rio", "TestAgentSpeed"))
                #self.beekeeper.actOnce('talk',target)























