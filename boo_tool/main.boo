import System
import System.Collections.Generic
import System.Reflection

namespace GameFramework

'''
A flexible object-oriented scripting framework designed for rapid game logic
prototyping and Unity-compatible gameplay systems.
Built strictly with Boo for clean, Python-like syntax with strong .NET typing.
'''

abstract class MonoBehaviour():
	private _enabled as bool = true
	private _active as bool = true
	private _deltaTime as double = 0.0
	
	get Enabled() as bool:
		return _enabled
	
	set Enabled(value as bool):
		_enabled = value
	
	get Active() as bool:
		return _active
	
	set Active(value as bool):
		_active = value

	def Update():
		'''
		Called once per frame. Override in derived classes for per-frame logic.
		'''
		pass

	def Start():
		'''
		Called once before the first Update. Use for initialization.
		'''
		pass

	def OnEnable():
		'''
		Called when the component is enabled.
		'''
		Active = true

	def OnDisable():
		'''
		Called when the component is disabled.
		'''
		Active = false

	def Destroy():
		'''
		Safely disable and mark for garbage collection.
		'''
		Enabled = false
		Active = false


class GameObject():
	private _name as string
	private _components as List[object]
	private _transform as Transform

	get Name() as string:
		return _name

	def __init__(self as string = "New GameObject"):
		_name = name
		_components = List[object]()
		_transform = Transform()
		_components.Add(_transform)

	def AddComponent(comp as object):
		if comp is MonoBehaviour:
			_components.Add(comp)
			comp.OnEnable()
			comp.Start()
		else:
			raise Exception("Only MonoBehaviour types can be added to GameObjects.")

	def Update(deltaTime as double):
		_deltaTime = deltaTime
		for comp in _components:
			if comp is MonoBehaviour:
				if comp.Enabled and comp.Active:
					comp.Update()

	def GetComponent[T]() as T:
		for comp in _components:
			if comp is T:
				return comp as T
		return null as T

class Transform():
	public Position as Vector3
	public Rotation as Vector3
	public Scale as Vector3

	def __init__():
		Position = Vector3(0.0, 0.0, 0.0)
		Rotation = Vector3(0.0, 0.0, 0.0)
		Scale = Vector3(1.0, 1.0, 1.0)

class Vector3():
	public X as double
	public Y as double
	public Z as double

	def __init__(self, x as double = 0.0, y as double = 0.0, z as double = 0.0):
		X = x
		Y = y
		Z = z

	def ToString() as string:
		return "Vector3(%.2f, %.2f, %.2f)" % (X, Y, Z)

class GameLogicSystem:
	'''
	Demonstrates a prototype game logic system using the framework.
	'''
	
	private _activeLogic as bool = true
	
	def __init__():
		pass
	
	def ExecuteFrame(frameNumber as int, deltaTime as double):
		if not _activeLogic:
			return

		player = GameObject("PlayerController")
		handler = PlayerHandler()
		player.AddComponent(handler)

		player.Update(deltaTime)
		Console.WriteLine("Frame %d processed. Player State: %s" % (frameNumber, handler.DebugState()))

	def DebugSystem():
		Console.WriteLine("GameLogicSystem is operational.")


class PlayerHandler(MonoBehaviour):
	private _moveSpeed as double = 5.0
	private _xPosition as double = 0.0

	def Update():
		if not Enabled or not Active:
			return
		
		_xPosition += _moveSpeed * DeltaTime()
		Console.WriteLine("Player moved to X: %.2f" % _xPosition)

	def DebugState() as string:
		return "PlayerHandler | X: %.2f | Speed: %.2f" % (_xPosition, _moveSpeed)

	def DeltaTime() as double:
		return _parent.DeltaTime if _parent else 0.0

    # Note: Boo requires explicit type casting in some contexts for clean interop.
    # This framework demonstrates the language's strong typing and OOP structure.

if __name__ == "GameFramework":
	Console.WriteLine("Initializing Boo Game Framework...")
	system = GameLogicSystem()
	system.ExecuteFrame(1, 0.016)  # Simulate 60 FPS frame
	system.ExecuteFrame(2, 0.016)
	system.ExecuteFrame(3, 0.016)
	
	Console.WriteLine("System complete. Boo framework ready for Unity/game prototyping.")
