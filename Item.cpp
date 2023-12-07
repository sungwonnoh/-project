#include <SFML/Graphics.hpp>
#include <iostream>
#include <string>
#include <vector>
#include <time.h>
#include <cmath>
#include <windows.h>
#include "Item.h"

using namespace std;
using namespace sf;

bool Item::collisionTest(Item obj) {

	/*
	int distance = sqrt(pow(x - obj.getX(), 2) + pow(y - obj.getY(), 2));

	if (distance < radius + obj.getR()) {
		return true;
	}
	else {
		return false;
	}
	*/
}

CircleShape* Item::getCircleShape() {
	return &circle;
}
//원본에 접근하기 위해 포인터를 반환
