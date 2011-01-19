/**
 * Copyright 2011 John Moore, Scott Gilroy
 *
 * This file is part of CollaboRhythm.
 *
 * CollaboRhythm is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
 *
 * CollaboRhythm is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along with CollaboRhythm.  If not, see <http://www.gnu.org/licenses/>.
*/
﻿/*
* Copyright (c) 2006-2007 Erin Catto http://www.gphysics.com
*
* This software is provided 'as-is', without any express or implied
* warranty.  In no event will the authors be held liable for any damages
* arising from the use of this software.
* Permission is granted to anyone to use this software for any purpose,
* including commercial applications, and to alter it and redistribute it
* freely, subject to the following restrictions:
* 1. The origin of this software must not be misrepresented; you must not
* claim that you wrote the original software. If you use this software
* in a product, an acknowledgment in the product documentation would be
* appreciated but is not required.
* 2. Altered source versions must be plainly marked as such, and must not be
* misrepresented as being the original software.
* 3. This notice may not be removed or altered from any source distribution.
*/

package Box2D.Dynamics.Contacts{


import Box2D.Collision.Shapes.*;
import Box2D.Collision.*;
import Box2D.Dynamics.*;
import Box2D.Common.*;
import Box2D.Common.Math.*;

import Box2D.Common.b2internal;
use namespace b2internal;


/**
* @private
*/
public class b2PolyAndCircleContact extends b2Contact{
	
	static public function Create(allocator:*):b2Contact{
		return new b2PolyAndCircleContact();
	}
	static public function Destroy(contact:b2Contact, allocator:*): void{
	}

	public function Reset(fixtureA:b2Fixture, fixtureB:b2Fixture):void{
		super.Reset(fixtureA, fixtureB);
		b2Settings.b2Assert(fixtureA.GetType() == b2Shape.e_polygonShape);
		b2Settings.b2Assert(fixtureB.GetType() == b2Shape.e_circleShape);
	}
	//~b2PolyAndCircleContact() {}

	b2internal override function Evaluate(): void{
		var bA:b2Body = m_fixtureA.m_body;
		var bB:b2Body = m_fixtureB.m_body;
		
		b2Collision.CollidePolygonAndCircle(m_manifold, 
					m_fixtureA.GetShape() as b2PolygonShape, bA.m_xf, 
					m_fixtureB.GetShape() as b2CircleShape, bB.m_xf);
	}
}

}